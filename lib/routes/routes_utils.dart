import 'package:flutter_cloud_music/common/model/play_queue_with_music.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

class RouteUtils {
  static Future<void> routeFromActionStr(String? action, {dynamic data}) async {
    if (action == null) return;
    logger.d(action);
    if (action.startsWith(Routes.ROUTES_HOST)) {
      //应用内跳转
      final path = action.substring(Routes.ROUTES_HOST.length, action.length);
      Get.toNamed('/$path');
      return;
    } else if (action.isURL) {
      Get.toNamed("${Routes.WEB}?url=$action");
    } else if (action == 'play_all_song') {
      //播放全部音乐
      final playQueue = data as PlayQueue;
      if (PlayerService.to.curPlayId.value.toString() ==
              playQueue.queue.first.mediaId &&
          PlayerService.to.watchPlayerValue.value?.queue.queueId ==
              playQueue.queueId) {
        //当前播放的列表和歌曲是同一个 掉起播放界面
        Get.toNamed(Routes.PLAYING);
      } else {
        PlayerService.to.player.playWithQueue(playQueue);
      }
    } else if (action == 'play_all_song_from_current_index') {
      //播放列表中的某一个
      final queueWithMusic = data as PlayQueueWithMusic;
      final playQueue = queueWithMusic.playQueue;
      final music = queueWithMusic.music;
      if (PlayerService.to.curPlayId.value.toString() == music.mediaId &&
          PlayerService.to.watchPlayerValue.value?.queue.queueId ==
              playQueue.queueId) {
        Get.toNamed(Routes.PLAYING);
      } else {
        PlayerService.to.player.playWithQueue(playQueue, metadata: music);
      }
    } else {
      Get.snackbar("", action);
    }
  }
}
