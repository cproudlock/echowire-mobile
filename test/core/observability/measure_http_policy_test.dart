import 'package:flutter_test/flutter_test.dart';
import 'package:fluxer_app/core/instance/instance_config_snapshot.dart';
import 'package:fluxer_app/core/observability/measure_http_policy.dart';

void main() {
  const MeasureHttpPolicy policy = kMeasureHttpPolicy;

  final InstanceConfigSnapshot official =
      InstanceConfigSnapshot.officialDefault();
  const InstanceConfigSnapshot selfHosted = InstanceConfigSnapshot(
    apiBaseUrl: 'https://chat.example.org/api/v1',
    gatewayUrl: 'wss://gateway.chat.example.org',
    displayDomain: 'chat.example.org',
  );

  test('tracks only official instance API hosts', () {
    expect(
      policy.shouldTrackHttpRequest(
        instance: official,
        requestUri: Uri.parse('https://echowire.org/api/v1/users/@me'),
      ),
      isTrue,
    );
    expect(
      policy.shouldTrackHttpRequest(
        instance: selfHosted,
        requestUri: Uri.parse('https://chat.example.org/api/v1/users/@me'),
      ),
      isFalse,
    );
  });

  test('isOfficialFluxerInstance accepts the official echowire hosts', () {
    const InstanceConfigSnapshot www = InstanceConfigSnapshot(
      apiBaseUrl: 'https://www.echowire.org/api/v1',
      gatewayUrl: 'wss://www.echowire.org/gateway',
      displayDomain: 'www.echowire.org',
    );
    expect(policy.isOfficialFluxerInstance(official), isTrue);
    expect(policy.isOfficialFluxerInstance(www), isTrue);
    expect(
      policy.shouldTrackHttpRequest(
        instance: www,
        requestUri: Uri.parse('https://www.echowire.org/api/v1/guilds'),
      ),
      isTrue,
    );
  });

  test('a Fluxer-hosted instance is not official for this fork', () {
    const InstanceConfigSnapshot fluxerHosted = InstanceConfigSnapshot(
      apiBaseUrl: 'https://fluxer.com/api/v1',
      gatewayUrl: 'wss://gateway.fluxer.com',
      displayDomain: 'fluxer.com',
    );
    expect(policy.isOfficialFluxerInstance(fluxerHosted), isFalse);
    expect(
      policy.shouldTrackHttpRequest(
        instance: fluxerHosted,
        requestUri: Uri.parse('https://fluxer.com/api/v1/guilds'),
      ),
      isFalse,
    );
  });
}
