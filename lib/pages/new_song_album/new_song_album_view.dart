import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/indicators/rectangular_indicator.dart';
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
          // tooltip: 'Back',
          padding: const EdgeInsets.only(left: 10.0),
          icon: Image.asset(
            ImageUtils.getImagePath('dij'),
            color:
                Get.isDarkMode ? Colours.white.withOpacity(0.9) : Colors.black,
            width: Dimens.gap_dp25,
            height: Dimens.gap_dp25,
          ),
        ),
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
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.tabController,
          children: [
            KeepAliveWrapper(
              child: NewSongPage(),
            ),
            Center(child: Text("这是推荐的内容")),
          ]),
    );
  }
}
