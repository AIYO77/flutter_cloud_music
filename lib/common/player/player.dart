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

  Rx<MusicPlayerValue?> get playerValueRx {
    try {
      return PlayerService.to.watchPlayerValue;
    } catch (e, stacktrace) {
      logger.e(stacktrace.toString());
      rethrow;
    }
  }

  Rx<Song?> get curPlayRx {
    try {
      return PlayerService.to.curPlay;
    } catch (e, stacktrace) {
      logger.e(stacktrace.toString());
      rethrow;
    }
  }

  Rx<PlayMode> get playModelRx {
    try {
      return PlayerService.to.playMode;
    } catch (e, stacktrace) {
      logger.e(stacktrace.toString());
      rethrow;
    }
  }

  TransportControls get transportControls => player.transportControls;

  PlaybackState? get playbackState => playerValueRx.value?.playbackState;
}

extension MusicPlayerValueExt on MusicPlayerValue {
  // int? get currentId => metadata == null ? null : int.parse(metadata!.mediaId);

  // int get currentIndex =>
  //     queue.queue.indexWhere((element) => element.mediaId == metadata?.mediaId);

  List<Song> get playingList =>
      queue.queue.map((e) => Song.fromMatedata(e)).toList();
}

extension PlaybackStateExt on PlaybackState {
  bool get hasError => state == PlayerState.Error;

  bool get isPlaying => (state == PlayerState.Playing) && !hasError;

  bool get isBuffering => state == PlayerState.Buffering;

  bool get initialized => state != PlayerState.None;
}

extension PlayQueueExt on PlayQueue {
  // 是否处于私人FM 播放模式
  bool get isPlayingFm => queueId == kFmPlayQueueId;
}

extension MusicPlayerExt on MusicPlayer {
  bool get initialized =>
      value.metadata != null && value.metadata!.duration > 0;

  /// 播放私人 FM
  /// [musics] 初始化数据
  void playFm(List<Song>? songs) {
    if (songs == null) return;
    final queue = PlayQueue(
        queueTitle: "私人FM",
        queueId: kFmPlayQueueId,
        queue: songs.toMetadataList());
    playWithQueue(queue);
  }
}

extension PlayModeDescription on PlayMode {
  String get iconPath {
    if (this == PlayMode.single) {
      return ImageUtils.getImagePath('play_btn_one');
    } else if (this == PlayMode.shuffle) {
      return ImageUtils.getImagePath('play_btn_shuffle');
    } else {
      return ImageUtils.getImagePath('play_btn_loop');
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

  PlayMode get next {
    if (this == PlayMode.sequence) {
      return PlayMode.shuffle;
    } else if (this == PlayMode.shuffle) {
      return PlayMode.single;
    } else {
      return PlayMode.sequence;
    }
  }
}
