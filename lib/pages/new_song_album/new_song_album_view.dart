import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/player/widgets/bottom_player_widget.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/indicators/rectangular_indicator.dart';
import 'package:flutter_cloud_music/pages/new_song_album/album/new_album_view.dart';
import 'package:flutter_cloud_music/pages/new_song_album/song/new_song_view.dart';
import 'package:flutter_cloud_music/widgets/btm_control.dart';
import 'package:flutter_cloud_music/widgets/keep_alive_wrapper.dart';
import 'package:get/get.dart';

import 'new_song_album_controller.dart';

class NewSongAlbumPage extends GetView<NewSongAlbumController> {
  const NewSongAlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.cardColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            Get.back();
          },
          icon: Image.asset(
            ImageUtils.getImagePath('dij'),
            color:
                Get.isDarkMode ? Colours.white.withOpacity(0.9) : Colors.black,
            width: Dimens.gap_dp25,
            height: Dimens.gap_dp25,
          ),
        ),
        centerTitle: true,
        title: Container(
          width: Dimens.gap_dp140,
          height: Dimens.gap_dp30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp105)),
              border: Border.all(
                  color: Colours.app_main_light.withOpacity(0.5),
                  width: Dimens.gap_dp1)),
          child: TabBar(
            tabs: controller.myTabs,
            labelColor: Colors.white,
            unselectedLabelColor: Colours.app_main_light,
            controller: controller.tabController,
            indicator: const RectangularIndicator(
              color: Colours.app_main_light,
              bottomLeftRadius: 100,
              bottomRightRadius: 100,
              topLeftRadius: 100,
              topRightRadius: 100,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          BottomPlayerController(
            TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: [
                KeepAliveWrapper(
                  child: NewSongPage(),
                ),
                KeepAliveWrapper(child: NewAlbumPage()),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: SlideTransition(
              position: controller.animation,
              child: Obx(
                () => BtmControlView(
                  canPressed:
                      GetUtils.isNullOrBlank(controller.selectedSong.value) !=
                          true,
                  nextPlayPressed: () {
                    if (GetUtils.isNullOrBlank(controller.selectedSong.value) !=
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
  }
}
