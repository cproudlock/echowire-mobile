import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluxer_app/features/channels/data/channel_repository.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_dart/export.dart';

import '../../../helpers/open_test_database.dart';

/// Echowire: a session payload leaves archived threads out, so a link straight
/// to an archived forum post names a channel this client has never cached.
/// [ChannelRepository.fetchChannelById] is the recovery for that.
class _ChannelAdapter implements HttpClientAdapter {
  _ChannelAdapter({required this.status, this.body = '{}'});

  final int status;
  final String body;
  final List<String> requestedPaths = <String>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestedPaths.add(options.uri.path);
    return ResponseBody.fromString(
      body,
      status,
      statusMessage: status == 200 ? 'OK' : 'Error',
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

ChannelRepository _repository(_ChannelAdapter adapter, dynamic db) {
  final Dio dio = Dio(BaseOptions(baseUrl: 'https://echowire.org/api/v1'))
    ..httpClientAdapter = adapter;
  return ChannelRepository(FluxerClient(dio), dio, db);
}

void main() {
  test('fetchChannelById caches an archived thread the database lacks', () async {
    final adapter = _ChannelAdapter(
      status: 200,
      body:
          '{"id":"thread-1","type":11,"guild_id":"guild-1",'
          '"name":"an archived post","parent_id":"forum-1"}',
    );
    final db = openTestDatabase();
    addTearDown(db.close);

    expect(await db.channelDao.getChannelById('thread-1'), isNull);

    final Channel? channel = await _repository(
      adapter,
      db,
    ).fetchChannelById('thread-1');

    expect(channel?.id, 'thread-1');
    expect(channel?.name, 'an archived post');
    expect(channel?.parentId, 'forum-1');
    expect(adapter.requestedPaths.single, '/api/v1/channels/thread-1');
    expect(await db.channelDao.getChannelById('thread-1'), isNotNull);
  });

  test('fetchChannelById returns null when the channel is gone', () async {
    final adapter = _ChannelAdapter(status: 404, body: '{"message":"Unknown Channel"}');
    final db = openTestDatabase();
    addTearDown(db.close);

    expect(await _repository(adapter, db).fetchChannelById('thread-gone'), isNull);
    expect(await db.channelDao.getChannelById('thread-gone'), isNull);
  });

  test('fetchChannelById returns null when the reader may not see it', () async {
    final adapter = _ChannelAdapter(status: 403, body: '{"message":"Missing Permissions"}');
    final db = openTestDatabase();
    addTearDown(db.close);

    expect(await _repository(adapter, db).fetchChannelById('thread-hidden'), isNull);
    expect(await db.channelDao.getChannelById('thread-hidden'), isNull);
  });

  test('fetchChannelById does not cache a channel with no guild', () async {
    final adapter = _ChannelAdapter(
      status: 200,
      body: '{"id":"dm-1","type":1,"name":"a direct message"}',
    );
    final db = openTestDatabase();
    addTearDown(db.close);

    expect(await _repository(adapter, db).fetchChannelById('dm-1'), isNull);
    expect(await db.channelDao.getChannelById('dm-1'), isNull);
  });

  test('fetchChannelById asks for nothing when the id is empty', () async {
    final adapter = _ChannelAdapter(status: 200);
    final db = openTestDatabase();
    addTearDown(db.close);

    expect(await _repository(adapter, db).fetchChannelById(''), isNull);
    expect(adapter.requestedPaths, isEmpty);
  });
}
