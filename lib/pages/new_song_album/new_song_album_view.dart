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
              child: _buildBtmLay(context),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBtmLay(BuildContext context) {
    return Container(
      height: Dimens.gap_dp56,
      width: Adapt.screenW(),
      color: Get.theme.cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBtmLayLabel(
              imagePath: 'btmlay_btn_next',
              name: '下一首播放',
              onPressed: () {
                if (GetUtils.isNullOrBlank(controller.selectedSong.value) !=
                    true) {
                  final list = controller.selectedSong.value!.reversed
                      .map((e) => e.metadata)
                      .toList();
                  context.player.insertListToNext(list);
                  controller.selectedSong.value = null;
                  toast('已添加到播放列表');
                }
              }),
          _buildBtmLayLabel(
              imagePath: 'btn_add',
              name: '收藏到歌单',
              onPressed: () {
                if (GetUtils.isNullOrBlank(controller.selectedSong.value) !=
                    true) notImplemented(context);
              }),
          _buildBtmLayLabel(
              imagePath: 'btmlay_btn_dld',
              name: '下载',
              onPressed: () {
                if (GetUtils.isNullOrBlank(controller.selectedSong.value) !=
                    true) notImplemented(context);
              }),
          _buildBtmLayLabel(
              imagePath: 'btmlay_btn_dlt',
              name: '删除下载',
              onPressed: () {
                if (GetUtils.isNullOrBlank(controller.selectedSong.value) !=
                    true) notImplemented(context);
              }),
        ],
      ),
    );
  }

  Widget _buildBtmLayLabel(
      {required String imagePath,
      required String name,
      required VoidCallback onPressed}) {
    return Expanded(
        child: Material(
      color: Get.theme.cardColor,
      child: InkWell(
        onTap: () {
          onPressed.call();
        },
        child: Obx(
          () => Opacity(
            opacity:
                GetUtils.isNullOrBlank(controller.selectedSong.value) == true
                    ? 0.5
                    : 1.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageUtils.getImagePath(imagePath),
                  width: Dimens.gap_dp26,
                  color: Get.isDarkMode
                      ? Colours.dark_subtitle_text
                      : Colours.subtitle_text,
                ),
                Text(
                  name,
                  style: captionStyle(),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
