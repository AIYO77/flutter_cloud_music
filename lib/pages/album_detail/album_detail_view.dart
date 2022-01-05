import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/player/widgets/bottom_player_widget.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/delegate/general_sliver_delegate.dart';
import 'package:flutter_cloud_music/pages/album_detail/delegate/album_detail_header_delegate.dart';
import 'package:flutter_cloud_music/pages/album_detail/widget/app_bar.dart';
import 'package:flutter_cloud_music/pages/album_detail/widget/fab_count.dart';
import 'package:flutter_cloud_music/pages/album_detail/widget/song_list.dart';
import 'package:flutter_cloud_music/widgets/playall_cell.dart';
import 'package:flutter_cloud_music/widgets/sliver_fab.dart';
import 'package:get/get.dart';

import 'album_detail_controller.dart';

class AlbumDetailPage extends GetView<AlbumDetailController> {
  const AlbumDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.log(controller.albumId);
    controller.appbarHeight = context.mediaQueryPadding.top + Adapt.px(44);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Adapt.px(44)),
          //appbar
          child: AlbumDetailAppBar(
            key: controller.appBarKey,
            appBarHeight: controller.appbarHeight,
          )),
      extendBodyBehindAppBar: true,
      backgroundColor: Get.theme.cardColor,
      body: BottomPlayerController(_buildContent(context)),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SliverFab(
      topScalingEdge: controller.appbarHeight,
      floatingWidget: AlbumDetailFabCount(),
      //收藏/评论/分享数 悬浮fab
      expandedHeight: controller.expandedHeight,
      floatingPosition:
          FloatingPosition(left: Adapt.px(50), right: Adapt.px(50), top: -6),
      slivers: <Widget>[
        //头部内容 背景和简介等
        SliverPersistentHeader(
            pinned: true,
            delegate: AlbumDetailSliverHeaderDelegate(
                expendHeight: controller.expandedHeight,
                minHeight: controller.appbarHeight)),
        //间距
        SliverPersistentHeader(
            delegate: GeneralSliverDelegate(
          child: PreferredSize(
              preferredSize: Size.fromHeight(Dimens.gap_dp32),
              child: Gaps.empty),
        )),
        //全部播放吸顶
        Obx(() => SliverPersistentHeader(
            pinned: true,
            delegate: GeneralSliverDelegate(
                child: PlayAllCell(
              playCount: controller.albumDetail.value?.songs.length ?? 0,
            )))),
        //歌曲列表
        Obx(() => AlbumDetailSongList(controller.albumDetail.value?.songs)),
        //pading bottom
        Obx(() => SliverToBoxAdapter(
              child: padingBottomBox(context.playerValueRx.value),
            ))
      ],
    );
  }
}
