import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

const String kFmPlayQueueId = "personal_fm";

extension QuitPlayerExt on BuildContext {
  PlayerService get playerService {
    try {
      return PlayerService.to;
    } catch (e, stacktrace) {
      logger.e(stacktrace.toString());
      rethrow;
    }
  }

  MusicPlayer get player {
    try {
      return PlayerService.to.player;
    } catch (e, stacktrace) {
      logger.e(stacktrace.toString());
      rethrow;
    }
  }
}

extension MusicPlayerValueExt on MusicPlayerValue {
  int? get currentId => metadata == null ? null : int.parse(metadata!.mediaId);
}

extension PlayQueueExt on PlayQueue {
  // 是否处于私人FM 播放模式
  bool get isPlayingFm => queueId == kFmPlayQueueId;
}

extension PlayModeDescription on PlayMode {
  String get iconPath {
    if (this == PlayMode.single) {
      return ImageUtils.getImagePath('eej');
    } else if (this == PlayMode.shuffle) {
      return ImageUtils.getImagePath('ef2');
    } else {
      return ImageUtils.getImagePath('ee9');
    }
  }

  String get name {
    if (this == PlayMode.single) {
      return "单曲循环";
    } else if (this == PlayMode.shuffle) {
      return "随机播放";
    } else {
      return "列表循环";
    }
  }
}
