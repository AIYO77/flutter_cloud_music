import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/player/widgets/bottom_player_widget.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/widgets/btm_control.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class RcmdSongDayPage extends GetView<RcmdSongDayController> {
  const RcmdSongDayPage({Key? key}) : super(key: key);

  Widget _buildView() {
    return const BottomPlayerController(RcmdDailyWidget());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RcmdSongDayController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: Get.theme.cardColor,
          body: Stack(
            children: [
              Positioned.fill(child: _buildView()),
              Positioned(
                bottom: 0,
                child: SlideTransition(
                  position: controller.animation,
                  child: Obx(
                    () => BtmControlView(
                      canPressed: GetUtils.isNullOrBlank(
                              controller.selectedSong.value) !=
                          true,
                      nextPlayPressed: () {
                        if (GetUtils.isNullOrBlank(
                                controller.selectedSong.value) !=
                            true) {
                          final list = controller.selectedSong.value!.reversed
                              .map((e) => e.metadata)
                              .toList();
                          context.player.insertListToNext(list);
                          controller.selectedSong.value = null;
                          toast('已添加到播放列表');
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
