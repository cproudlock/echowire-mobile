import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/talker.dart';
import 'package:fluxer_app/core/theme/fluxer_theme_extension.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/domain/forum_view.dart';
import 'package:fluxer_app/features/channels/presentation/channel_settings/widgets/channel_settings_control_row.dart';
import 'package:fluxer_app/features/channels/providers/channel_providers.dart';
import 'package:fluxer_app/features/channels/providers/thread_providers.dart';
import 'package:fluxer_app/features/ui/button/fluxer_button.dart';
import 'package:fluxer_app/features/ui/input/fluxer_input.dart';
import 'package:fluxer_app/features/ui/select/fluxer_select.dart';
import 'package:fluxer_app/features/ui/toast/fluxer_toast.dart';
import 'package:fluxer_app/features/ui/toast/toast_provider.dart';
import 'package:fluxer_app/features/ui/toggle_switch/fluxer_toggle_switch.dart';
import 'package:fluxer_app/l10n/generated/fluxer_localizations.dart';
import 'package:fluxer_app/material_ui.dart';

/// Echowire: the forum-only settings a manager can change: post guidelines,
/// required tags, default sort and layout, the default reaction, when posts
/// hide after inactivity, and slowmode for new posts and inside posts. Tags
/// themselves are managed from the forum view. Saves on its own button so it
/// does not interfere with the overview form.
class ChannelOverviewForumSection extends ConsumerStatefulWidget {
  const ChannelOverviewForumSection({
    required this.channel,
    required this.slowmodeItems,
    super.key,
  });

  final Channel channel;
  final List<FluxerSelectItem<int>> slowmodeItems;

  @override
  ConsumerState<ChannelOverviewForumSection> createState() =>
      _ChannelOverviewForumSectionState();
}

/// Auto-archive durations in minutes, matching Discord's choices.
const List<int> _kHideAfterMinutes = <int>[60, 1440, 4320, 10080];

class _ForumSettingsDraft {
  const _ForumSettingsDraft({
    required this.guidelines,
    required this.requireTag,
    required this.sortOrder,
    required this.layout,
    required this.reactionEmoji,
    required this.hideAfterMinutes,
    required this.postCreationSlowmode,
    required this.defaultPostSlowmode,
  });

  factory _ForumSettingsDraft.from(Channel forum, ForumExtras? extras) {
    String reaction = '';
    final String? json = forum.defaultReactionEmojiJson;
    if (json != null && json.isNotEmpty) {
      final Object? decoded = jsonDecode(json);
      if (decoded is Map<String, dynamic>) {
        reaction = decoded['emoji_name'] as String? ?? '';
      }
    }
    final int hideAfter = forum.forumDefaultAutoArchiveDuration ?? 4320;
    return _ForumSettingsDraft(
      guidelines: forum.topic ?? '',
      requireTag: forum.forumRequireTag ?? false,
      sortOrder: ForumSortOrder.fromWire(forum.defaultSortOrder),
      layout: ForumLayout.fromWire(extras?.defaultLayout),
      reactionEmoji: reaction,
      hideAfterMinutes: _kHideAfterMinutes.contains(hideAfter)
          ? hideAfter
          : 4320,
      postCreationSlowmode: forum.rateLimitPerUser,
      defaultPostSlowmode: extras?.defaultThreadRateLimitPerUser ?? 0,
    );
  }

  final String guidelines;
  final bool requireTag;
  final ForumSortOrder sortOrder;
  final ForumLayout layout;
  final String reactionEmoji;
  final int hideAfterMinutes;
  final int postCreationSlowmode;
  final int defaultPostSlowmode;

  _ForumSettingsDraft copyWith({
    String? guidelines,
    bool? requireTag,
    ForumSortOrder? sortOrder,
    ForumLayout? layout,
    String? reactionEmoji,
    int? hideAfterMinutes,
    int? postCreationSlowmode,
    int? defaultPostSlowmode,
  }) => _ForumSettingsDraft(
    guidelines: guidelines ?? this.guidelines,
    requireTag: requireTag ?? this.requireTag,
    sortOrder: sortOrder ?? this.sortOrder,
    layout: layout ?? this.layout,
    reactionEmoji: reactionEmoji ?? this.reactionEmoji,
    hideAfterMinutes: hideAfterMinutes ?? this.hideAfterMinutes,
    postCreationSlowmode: postCreationSlowmode ?? this.postCreationSlowmode,
    defaultPostSlowmode: defaultPostSlowmode ?? this.defaultPostSlowmode,
  );

  /// The PATCH fields that differ from [original].
  Map<String, Object?> changesFrom(_ForumSettingsDraft original) {
    final String emoji = reactionEmoji.trim();
    return <String, Object?>{
      if (guidelines != original.guidelines) 'topic': guidelines,
      if (requireTag != original.requireTag) 'require_tag': requireTag,
      if (sortOrder != original.sortOrder)
        'default_sort_order': sortOrder.wireValue,
      if (layout != original.layout) 'default_forum_layout': layout.wireValue,
      if (emoji != original.reactionEmoji.trim())
        'default_reaction_emoji': emoji.isEmpty
            ? null
            : <String, Object?>{'emoji_id': null, 'emoji_name': emoji},
      if (hideAfterMinutes != original.hideAfterMinutes)
        'default_auto_archive_duration': hideAfterMinutes,
      if (postCreationSlowmode != original.postCreationSlowmode)
        'rate_limit_per_user': postCreationSlowmode,
      if (defaultPostSlowmode != original.defaultPostSlowmode)
        'default_thread_rate_limit_per_user': defaultPostSlowmode,
    };
  }
}

class _ChannelOverviewForumSectionState
    extends ConsumerState<ChannelOverviewForumSection> {
  late _ForumSettingsDraft _original;
  late _ForumSettingsDraft _current;
  late final TextEditingController _guidelines;
  late final TextEditingController _reaction;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _original = _ForumSettingsDraft.from(
      widget.channel,
      ref.read(forumExtrasProvider(widget.channel.id)),
    );
    _current = _original;
    _guidelines = TextEditingController(text: _current.guidelines);
    _reaction = TextEditingController(text: _current.reactionEmoji);
    unawaited(_loadExtras());
  }

  Future<void> _loadExtras() async {
    final ForumExtras? extras = await ref
        .read(threadRepositoryProvider)
        .loadForumExtras(widget.channel.id);
    if (!mounted || extras == null || _isDirty) {
      return;
    }
    setState(() {
      _original = _ForumSettingsDraft.from(widget.channel, extras);
      _current = _original;
    });
  }

  @override
  void dispose() {
    _guidelines.dispose();
    _reaction.dispose();
    super.dispose();
  }

  bool get _isDirty => _current.changesFrom(_original).isNotEmpty;

  void _update(_ForumSettingsDraft next) => setState(() => _current = next);

  Future<void> _save() async {
    final Map<String, Object?> fields = _current.changesFrom(_original);
    if (_saving || fields.isEmpty) {
      return;
    }
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final Toast toast = ref.read(toastProvider.notifier);
    setState(() => _saving = true);
    try {
      final result = await ref
          .read(channelRepositoryProvider)
          .updateForumSettings(
            forumId: widget.channel.id,
            guildId: widget.channel.guildId,
            fields: fields,
          );
      ref
          .read(threadRepositoryProvider)
          .rememberForumExtras(widget.channel.id, result.extras);
      if (!mounted) {
        return;
      }
      setState(() => _original = _current);
      toast.show(
        FluxerToast(
          message: l10n.forumSettingsSaved,
          variant: FluxerToastVariant.success,
        ),
      );
    } on Exception catch (e, st) {
      talker.error('Could not save forum settings', e, st);
      toast.show(
        FluxerToast(
          message: l10n.forumSettingsSaveFailed,
          variant: FluxerToastVariant.danger,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final layout = context.layout;
    final textStyles = context.textStyles;

    String hideAfterLabel(int minutes) => switch (minutes) {
      60 => l10n.forumSettingsHideAfterOneHour,
      1440 => l10n.forumSettingsHideAfterOneDay,
      4320 => l10n.forumSettingsHideAfterThreeDays,
      _ => l10n.forumSettingsHideAfterOneWeek,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          l10n.forumSettingsTitle,
          style: textStyles.heading.copyWith(fontSize: 16),
        ),
        SizedBox(height: layout.s4),
        FluxerInput.multiline(
          label: l10n.forumPostGuidelinesLabel,
          hint: l10n.forumSettingsGuidelinesHint,
          controller: _guidelines,
          maxLines: 5,
          maxLength: 1024,
          onChanged: (String value) =>
              _update(_current.copyWith(guidelines: value)),
        ),
        SizedBox(height: layout.s4),
        FluxerToggleSwitch(
          value: _current.requireTag,
          label: l10n.forumSettingsRequireTag,
          description: l10n.forumSettingsRequireTagDescription,
          onChanged: (bool value) =>
              _update(_current.copyWith(requireTag: value)),
        ),
        SizedBox(height: layout.s4),
        FluxerSelect<ForumSortOrder>(
          label: l10n.forumSettingsDefaultSort,
          value: _current.sortOrder,
          stretch: true,
          enableSearch: false,
          items: <FluxerSelectItem<ForumSortOrder>>[
            FluxerSelectItem<ForumSortOrder>(
              value: ForumSortOrder.latestActivity,
              label: l10n.forumSortRecentActivity,
            ),
            FluxerSelectItem<ForumSortOrder>(
              value: ForumSortOrder.creationDate,
              label: l10n.forumSortDatePosted,
            ),
          ],
          onChanged: (ForumSortOrder value) =>
              _update(_current.copyWith(sortOrder: value)),
        ),
        SizedBox(height: layout.s4),
        FluxerSelect<ForumLayout>(
          label: l10n.forumSettingsDefaultLayout,
          value: _current.layout,
          stretch: true,
          enableSearch: false,
          items: <FluxerSelectItem<ForumLayout>>[
            FluxerSelectItem<ForumLayout>(
              value: ForumLayout.list,
              label: l10n.forumLayoutList,
            ),
            FluxerSelectItem<ForumLayout>(
              value: ForumLayout.gallery,
              label: l10n.forumLayoutGallery,
            ),
          ],
          onChanged: (ForumLayout value) =>
              _update(_current.copyWith(layout: value)),
        ),
        SizedBox(height: layout.s4),
        ChannelSettingsControlRow(
          label: l10n.forumSettingsDefaultReaction,
          description: l10n.forumSettingsDefaultReactionDescription,
          child: FluxerInput(
            controller: _reaction,
            hint: l10n.forumSettingsDefaultReactionHint,
            maxLength: 16,
            onChanged: (String value) =>
                _update(_current.copyWith(reactionEmoji: value)),
          ),
        ),
        SizedBox(height: layout.s4),
        FluxerSelect<int>(
          label: l10n.forumSettingsHideAfterInactivity,
          description: l10n.forumSettingsHideAfterInactivityDescription,
          value: _current.hideAfterMinutes,
          stretch: true,
          enableSearch: false,
          items: <FluxerSelectItem<int>>[
            for (final int minutes in _kHideAfterMinutes)
              FluxerSelectItem<int>(
                value: minutes,
                label: hideAfterLabel(minutes),
              ),
          ],
          onChanged: (int value) =>
              _update(_current.copyWith(hideAfterMinutes: value)),
        ),
        SizedBox(height: layout.s4),
        FluxerSelect<int>(
          label: l10n.forumSettingsPostCreationSlowmode,
          description: l10n.forumSettingsPostCreationSlowmodeDescription,
          value: _current.postCreationSlowmode,
          stretch: true,
          enableSearch: false,
          items: widget.slowmodeItems,
          onChanged: (int value) =>
              _update(_current.copyWith(postCreationSlowmode: value)),
        ),
        SizedBox(height: layout.s4),
        FluxerSelect<int>(
          label: l10n.forumSettingsDefaultPostSlowmode,
          description: l10n.forumSettingsDefaultPostSlowmodeDescription,
          value: _current.defaultPostSlowmode,
          stretch: true,
          enableSearch: false,
          items: widget.slowmodeItems,
          onChanged: (int value) =>
              _update(_current.copyWith(defaultPostSlowmode: value)),
        ),
        SizedBox(height: layout.s4),
        FluxerButton.primary(
          label: l10n.forumSettingsSave,
          onPressed: _isDirty && !_saving ? () => unawaited(_save()) : null,
        ),
      ],
    );
  }
}
