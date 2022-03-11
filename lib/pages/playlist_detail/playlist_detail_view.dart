import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/widgets/bottom_player_widget.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/delegate/general_sliver_delegate.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/delegate/playlist_header_delegate.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widget/fab_count.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widget/list_content.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widget/play_all.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widget/top_appbar.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widget/video_list.dart';
import 'package:flutter_cloud_music/widgets/sliver_fab.dart';
import 'package:get/get.dart';

import 'playlist_detail_controller.dart';

/*
 * @Author: XingWei 
 * @Date: 2021-10-08 14:15:15 
 * @Last Modified by:   XingWei 
 * @Last Modified time: 2021-10-08 14:15:15 
 */

class PlaylistDetailPage extends GetView<PlaylistDetailController> {
  PlaylistDetailPage({Key? key}) : super(key: key);

  double appbarHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    Get.log(controller.playlistId);
    appbarHeight = context.mediaQueryPadding.top + Adapt.px(44);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Adapt.px(44)),
          //appbar
          child: PlaylistTopAppbar(
            key: controller.appBarKey,
            appBarHeight: appbarHeight,
          )),
      extendBodyBehindAppBar: true,
      backgroundColor: Get.theme.cardColor,
      body: BottomPlayerController(_buildContent(context)),
    );
  }

  //滚动内容区
  Widget _buildContent(BuildContext context) {
    return SliverFab(
      topScalingEdge: appbarHeight,
      floatingWidget: PlaylistFabCount(),
      //收藏/评论/分享数 悬浮fab
      expandedHeight: controller.expandedHeight,
      floatingPosition:
          FloatingPosition(left: Adapt.px(50), right: Adapt.px(50), top: -6),
      slivers: <Widget>[
        //头部内容 背景和简介等
        SliverPersistentHeader(
            pinned: true,
            delegate: PlaylistSliverHeaderDelegate(
                expendHeight: controller.expandedHeight,
                minHeight: appbarHeight)),
        //间距
        SliverPersistentHeader(
            delegate: GeneralSliverDelegate(
          child: PreferredSize(
              preferredSize: Size.fromHeight(Dimens.gap_dp32),
              child: Gaps.empty),
        )),
        //全部播放吸顶
        SliverPersistentHeader(
            pinned: true,
            delegate: GeneralSliverDelegate(child: PlDetailPlayAll())),
        //列表
        Obx(() => controller.detail.value?.playlist.specialType == 200
            ? VideoListContent(controller.detail.value!.playlist.videos)
            : PlayListContent(controller.songs.value)),
        //pading bottom
        SliverToBoxAdapter(
          child: padingBottomBox(),
        )
      ],
    );
  }
}
