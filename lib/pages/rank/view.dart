import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/pages/rank/widgets/global_rank.dart';
import 'package:flutter_cloud_music/pages/rank/widgets/official_rank.dart';
import 'package:flutter_cloud_music/pages/rank/widgets/rcmd_rank.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:flutter_cloud_music/widgets/my_app_bar.dart';
import 'package:get/get.dart';

import 'logic.dart';

class RankPage extends GetView<RankLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.isDarkMode ? Colours.dark_bg_color : Colours.color_242,
      appBar: MyAppBar(
        backgroundColor: bgColor,
        centerTitle: '排行榜',
      ),
      body: Obx(() => (controller.items.value == null)
          ? MusicLoading().paddingOnly(top: Dimens.gap_dp100)
          : CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                //推荐榜单
                SliverToBoxAdapter(
                  child: Container(
                    color: bgColor,
                    child: RecmRankWidget(),
                  ),
                ),
                //官方榜
                SliverToBoxAdapter(
                  child: OfficialRank(
                    bgColor: bgColor,
                    items: controller.items.value!
                        .where((element) => element.tracks.isNotEmpty)
                        .toList(),
                  ),
                ),
                //全球榜
                SliverToBoxAdapter(
                  child: GlobalRank(
                      bgColor: bgColor,
                      items: controller.items.value!
                          .where((element) => element.tracks.isEmpty)
                          .toList()),
                )
              ],
            )),
    );
  }

  Color get bgColor =>
      Get.isDarkMode ? Colours.dark_bg_color : Colours.color_250;
}
