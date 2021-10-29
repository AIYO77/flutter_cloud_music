import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

class PlayerContoller extends GetxController {
  late PageController pageController;

  final isFmPlaying = false.obs;

  final isPlaying = false.obs;

  bool isManual = false;

  @override
  void onInit() {
    // pageController = PageController(
    //     initialPage: getCurPage(
    //         PlayerService.to.watchPlayerValue.value?.queue.queue,
    //         PlayerService.to.curPlayId.value.toString()));
    PlayerService.to.player.addListener(_onPlayerChanged);
    super.onInit();
  }

  int getCurPage(List<MusicMetadata>? queue, String? curPlayId) {
    final initialPage =
        queue?.indexWhere((element) => element.mediaId == curPlayId.toString());
    return initialPage ?? 0;
  }

  Future<void> playFromIndex(BuildContext context, int index) async {
    final queue = context.playerValueRx.value?.queue.queue;
    if (GetUtils.isNullOrBlank(queue) != true) {
      final music = queue!.elementAt(index);
      isManual = true;
      await context.transportControls.playFromMediaId(music.mediaId);
    }
    isManual = false;
  }

  void _onPlayerChanged() {
    isFmPlaying.value = PlayerService.to.player.queue.queueId == kFmPlayQueueId;
    isPlaying.value = PlayerService.to.player.playbackState.isPlaying;
    final curPage = getCurPage(PlayerService.to.player.queue.queue,
        PlayerService.to.player.metadata?.mediaId);
    if (!isManual) {
      pageController.animateToPage(curPage,
          duration: const Duration(milliseconds: 16),
          curve: Curves.fastOutSlowIn);
    }
  }

  @override
  void onClose() {
    PlayerService.to.player.removeListener(_onPlayerChanged);
    super.onClose();
  }
}
