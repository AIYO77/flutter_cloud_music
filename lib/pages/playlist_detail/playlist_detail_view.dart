import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/delegate/general_sliver_delegate.dart';
import 'package:flutter_cloud_music/delegate/playlist_header_delegate.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widget/fab_count.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widget/top_appbar.dart';
import 'package:flutter_cloud_music/widgets/sliver_fab.dart';
import 'package:get/get.dart';
import 'playlist_detail_controller.dart';

// ignore: must_be_immutable
class PlaylistDetailPage extends GetView<PlaylistDetailController> {
  PlaylistDetailPage({Key? key}) : super(key: key);

  double appbarHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    Get.log(controller.playlistId);
    appbarHeight = context.mediaQueryPadding.top + Adapt.px(44);
    return Scaffold(
      backgroundColor: Get.theme.cardColor,
      body: Builder(builder: (context) {
        return Stack(
          children: [
            _buildContent(),
            //伪appbar
            SizedBox(
              height: appbarHeight,
              child: PlaylistTopAppbar(),
            )
          ],
        );
      }),
    );
  }

  //滚动内容区
  Widget _buildContent() {
    return SliverFab(
      topScalingEdge: appbarHeight,
      floatingWidget: PlaylistFabCount(), //收藏/评论/分享数 悬浮fab
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
                preferredSize: Size.fromHeight(Dimens.gap_dp42),
                child: Gaps.empty),
          ),
        ),
        //全部播放吸顶
        SliverPersistentHeader(
            pinned: true,
            delegate: GeneralSliverDelegate(
                child: PreferredSize(
                    preferredSize: Size(Adapt.screenW(), 40),
                    child: Container(
                        // color: Colors.amber,
                        )))),
        //歌曲列表
        SliverList(
          delegate: SliverChildListDelegate(
            List.generate(
              30,
              (int index) => ListTile(title: Text("Item $index")),
            ),
          ),
        ),
      ],
    );
  }
}
