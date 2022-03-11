import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/delegate/general_sliver_delegate.dart';
import 'package:flutter_cloud_music/pages/mine/widget/bar.dart';
import 'package:flutter_cloud_music/pages/mine/widget/create_pl_bs.dart';
import 'package:flutter_cloud_music/pages/mine/widget/manage_bs.dart';
import 'package:flutter_cloud_music/pages/mine/widget/pl_cell.dart';
import 'package:flutter_cloud_music/pages/mine/widget/tab.dart';
import 'package:flutter_cloud_music/pages/mine/widget/user_card.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../common/model/mine_playlist.dart';
import '../../common/utils/adapt.dart';
import 'mine_controller.dart';

class MinePage extends StatelessWidget {
  MinePage({Key? key}) : super(key: key);

  final controller = GetInstance().putOrFind(() => MineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // physics: const ClampingScrollPhysics(),
        controller: controller.scrollController,
        slivers: [
          MineViewBar(),
          SliverToBoxAdapter(
            child: MineUserCard(),
          ),
          Obx(() => _buildMineLikePl(
              context, controller.minePlaylist.value?.getIntelligent())),
          Obx(() => _buildPlTab(controller.minePlaylist.value)),
          Obx(() => _buildMyPlaylist(
              context, controller.minePlaylist.value?.getMineCreate())),
          Obx(() => _buildCollectPlaylist(
              context, controller.minePlaylist.value?.getMineCollect())),
          SliverToBoxAdapter(
            child: padingBottomBox(append: Dimens.gap_dp60),
          )
        ],
      ),
    );
  }

  ///我喜欢的音乐歌单
  Widget _buildMineLikePl(BuildContext context, MinePlaylist? likePl) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(
            top: Dimens.gap_dp18,
            left: Dimens.gap_dp16,
            bottom: Dimens.gap_dp18,
            right: Dimens.gap_dp16),
        padding: EdgeInsets.only(
            left: Dimens.gap_dp15,
            right: Dimens.gap_dp15,
            top: Dimens.gap_dp12,
            bottom: Dimens.gap_dp12),
        decoration: _buildCardBg(context, radius: 12),
        child: MinePlaylistCell(null, playlist: likePl),
      ),
    );
  }

  ///tab
  Widget _buildPlTab(List<MinePlaylist>? value) {
    return SliverPersistentHeader(
        pinned: true,
        delegate: GeneralSliverDelegate(
            child: PreferredSize(
          preferredSize: Size.fromHeight(Dimens.gap_dp44),
          child: MineTabView(),
        )));
  }

  ///自己创建的歌单
  Widget _buildMyPlaylist(BuildContext context, List<MinePlaylist>? list) {
    return SliverToBoxAdapter(
      child: _buildListCard(
        key: controller.createKey,
        context: context,
        childSize: list?.length ?? 1,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: Dimens.gap_dp15,
                  right: Dimens.gap_dp15,
                  bottom: Dimens.gap_dp8),
              child: Row(
                children: [
                  Text(
                    list == null ? '创建歌单' : '创建歌单(${list.length}个)',
                    style: captionStyle(),
                  ),
                  const Expanded(child: Gaps.empty),
                  GestureDetector(
                    onTap: () {
                      afterLogin(() {
                        CreatePlBottomSheet.show(context);
                      });
                    },
                    child: Image.asset(
                      ImageUtils.getImagePath('eh7'),
                      color: captionStyle().color?.withOpacity(0.7),
                      width: Dimens.gap_dp20,
                    ),
                  ),
                  Gaps.hGap16,
                  GestureDetector(
                    onTap: () {
                      MinePlBottomSheet.show(context, list, true);
                    },
                    child: Image.asset(
                      ImageUtils.getImagePath('cb'),
                      color: captionStyle().color?.withOpacity(0.7),
                      width: Dimens.gap_dp20,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: GetUtils.isNullOrBlank(list) == true
                    ? Center(
                        child: Text(
                          '暂无创建的歌单',
                          style: captionStyle()
                              .copyWith(fontSize: Dimens.font_sp13),
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final pl = list!.elementAt(index);
                          return _buildItem(pl);
                        },
                        separatorBuilder: (context, index) {
                          return Gaps.vGap6;
                        },
                        itemCount: list?.length ?? 0,
                      ))
          ],
        ),
      ),
    );
  }

  ///收藏的歌单
  Widget _buildCollectPlaylist(BuildContext context, List<MinePlaylist>? list) {
    return SliverToBoxAdapter(
      child: _buildListCard(
        key: controller.collectKey,
        context: context,
        childSize: list?.length ?? 1,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: Dimens.gap_dp15,
                  right: Dimens.gap_dp15,
                  bottom: Dimens.gap_dp8),
              child: Row(
                children: [
                  Text(
                    list == null ? '收藏歌单' : '收藏歌单(${list.length}个)',
                    style: captionStyle(),
                  ),
                  const Expanded(child: Gaps.empty),
                  GestureDetector(
                    onTap: () {
                      MinePlBottomSheet.show(context, list, false);
                    },
                    child: Image.asset(
                      ImageUtils.getImagePath('cb'),
                      color: captionStyle().color?.withOpacity(0.7),
                      width: Dimens.gap_dp20,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: GetUtils.isNullOrBlank(list) == true
                    ? Center(
                        child: Text(
                          '暂无收藏的歌单',
                          style: captionStyle()
                              .copyWith(fontSize: Dimens.font_sp13),
                        ),
                      )
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final pl = list!.elementAt(index);
                          return _buildItem(pl);
                        },
                        separatorBuilder: (context, index) {
                          return Gaps.vGap6;
                        },
                        itemCount: list?.length ?? 0,
                      ))
          ],
        ),
      ),
    );
  }

  Widget _buildItem(MinePlaylist pl) {
    return Slidable(
        key: Key(pl.id.toString()),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                toast('删除');
              },
              backgroundColor: Colours.app_main_light,
              foregroundColor: Colors.white,
              label: '删除',
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
          child: MinePlaylistCell(Key(pl.id.toString()), playlist: pl),
        ));
  }

  Widget _buildListCard(
      {required Key key,
      required BuildContext context,
      required Widget child,
      required int childSize}) {
    return Container(
      key: key,
      decoration: _buildCardBg(context, radius: 12),
      padding: EdgeInsets.only(top: Dimens.gap_dp17, bottom: Dimens.gap_dp17),
      margin: EdgeInsets.fromLTRB(
          Dimens.gap_dp16, Dimens.gap_dp18, Dimens.gap_dp16, 0),
      height: childSize * Dimens.gap_dp52 +
          (childSize - 1) * Dimens.gap_dp6 +
          Dimens.gap_dp17 * 2 +
          Dimens.gap_dp28,
      child: child,
    );
  }

  Decoration _buildCardBg(BuildContext context, {double radius = 16}) {
    return BoxDecoration(
        color: context.theme.cardColor,
        gradient: context.isDarkMode
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                    Colors.white12,
                    Colors.white.withOpacity(0.05),
                  ])
            : null,
        borderRadius: BorderRadius.all(
          Radius.circular(Adapt.px(radius)),
        ),
        boxShadow: [
          BoxShadow(
            color: context.theme.shadowColor,
            blurRadius: Dimens.gap_dp18,
          )
        ]);
  }
}
