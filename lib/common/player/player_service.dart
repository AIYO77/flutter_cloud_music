import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

const _keyPlayQueue = "quiet_player_queue";
const _keyCurrentPlaying = "quiet_current_playing";
const _keyPlayMode = "quiet_play_mode";

class PlayerService extends GetxService {
  static PlayerService get to => Get.find();

  late MusicPlayer player;

  //当前播放的歌曲ID
  final curPlayId = Rx<int?>(null);
  //播放模式
  final playMode = Rx<PlayMode>(PlayMode.sequence);
  //播放控制器
  final transportControls = Rx<TransportControls?>(null);
  //播放属性
  final watchPlayerValue = Rx<MusicPlayerValue?>(null);

  @override
  void onInit() {
    player = MusicPlayer();
    player.addListener(() {
      update();
    });
    player.metadataListenable.addListener(() {
      box.write(_keyCurrentPlaying, player.metadata!.toMap());
    });
    player.playModeListenable.addListener(() {
      box.write(_keyPlayMode, {"mode": player.playMode.index});
    });
    player.queueListenable.addListener(() {
      box.write(_keyPlayQueue, player.queue.toMap());
    });
    player.isMusicServiceAvailable().then((available) {
      if (available!) {
        return;
      }
      final MusicMetadata? metadata = _restoreMetadata();
      final PlayQueue? queue = _restorePlayQueue();
      if (metadata == null || queue == null) {
        return;
      }
      player.setPlayQueue(queue);
      player.transportControls.prepareFromMediaId(metadata.mediaId);
      player.transportControls.setPlayMode(_restorePlayMode());
    });
    super.onInit();
  }

  void update() {
    playMode.value = player.playMode;
    transportControls.value = player.transportControls;
    watchPlayerValue.value = player.value;
    curPlayId.value = int.tryParse(player.metadata?.mediaId ?? '-1');
  }

  MusicMetadata? _restoreMetadata() {
    final map = box.read<Map<dynamic, dynamic>>(_keyCurrentPlaying);
    if (map == null) {
      return null;
    } else {
      return MusicMetadata.fromMap(map);
    }
  }

  PlayQueue? _restorePlayQueue() {
    final map = box.read<Map<dynamic, dynamic>>(_keyPlayQueue);
    if (map == null) {
      return null;
    } else {
      return PlayQueue.fromMap(map);
    }
  }

  PlayMode _restorePlayMode() {
    final map = box.read<Map<dynamic, dynamic>>(_keyPlayMode);
    if (map == null) {
      return PlayMode.sequence;
    } else {
      final int? mode = map["mode"] as int? ?? PlayMode.sequence.index;
      return PlayMode(mode);
    }
  }
}
