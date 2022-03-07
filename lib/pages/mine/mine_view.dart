import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/delegate/general_sliver_delegate.dart';
import 'package:flutter_cloud_music/pages/mine/widget/bar.dart';
import 'package:flutter_cloud_music/pages/mine/widget/pl_cell.dart';
import 'package:flutter_cloud_music/pages/mine/widget/tab.dart';
import 'package:flutter_cloud_music/pages/mine/widget/user_card.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
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
              context,
              controller.minePlaylist.value
                  ?.firstWhere((element) => element.isIntelligent()))),
          Obx(() => _buildPlTab(controller.minePlaylist.value)),
          Obx(() => _buildMyPlaylist(
              context,
              controller.minePlaylist.value
                  ?.where((element) =>
                      element.creator.userId == AuthService.to.userId &&
                      element.specialType != 5)
                  .toList())),
          Obx(() => _buildCollectPlaylist(
              context,
              controller.minePlaylist.value
                  ?.where((element) =>
                      element.creator.userId != AuthService.to.userId)
                  .toList())),
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
      child: likePl == null
          ? null
          : Container(
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
              child:
                  MinePlaylistCell(Key(likePl.id.toString()), playlist: likePl),
            ),
    );
  }

  ///tab
  Widget _buildPlTab(List<MinePlaylist>? value) {
    if (GetUtils.isNullOrBlank(value) == true) {
      return const SliverToBoxAdapter();
    }
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
    if (list == null) {
      return const SliverToBoxAdapter();
    }
    return SliverToBoxAdapter(
      child: _buildListCard(
          key: controller.createKey,
          context: context,
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
                      '创建歌单(${list.length}个)',
                      style: captionStyle(),
                    ),
                    const Expanded(child: Gaps.empty),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        ImageUtils.getImagePath('eh7'),
                        color: captionStyle().color?.withOpacity(0.7),
                        width: Dimens.gap_dp20,
                      ),
                    ),
                    Gaps.hGap16,
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(_buildManageSheet(context, list, true),
                            enableDrag: false,
                            backgroundColor: Colors.transparent);
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
                  child: ListView.separated(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final pl = list.elementAt(index);
                  return _buildItem(pl);
                },
                separatorBuilder: (context, index) {
                  return Gaps.vGap6;
                },
                itemCount: list.length,
              ))
            ],
          ),
          childSize: list.length),
    );
  }

  ///收藏的歌单
  Widget _buildCollectPlaylist(BuildContext context, List<MinePlaylist>? list) {
    if (list == null) {
      return const SliverToBoxAdapter(
        child: Gaps.empty,
      );
    }
    return SliverToBoxAdapter(
      child: _buildListCard(
        key: controller.collectKey,
        context: context,
        childSize: list.length,
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
                    '收藏歌单(${list.length}个)',
                    style: captionStyle(),
                  ),
                  const Expanded(child: Gaps.empty),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(_buildManageSheet(context, list, false),
                          enableDrag: false,
                          backgroundColor: Colors.transparent);
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
                child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final pl = list.elementAt(index);
                return _buildItem(pl);
              },
              separatorBuilder: (context, index) {
                return Gaps.vGap6;
              },
              itemCount: list.length,
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

  Widget _buildManageSheet(
      BuildContext context, List<MinePlaylist> list, bool isCreatePl) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(Dimens.gap_dp14),
          topLeft: Radius.circular(Dimens.gap_dp14),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: Dimens.gap_dp50,
            padding: EdgeInsets.only(left: Dimens.gap_dp15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                isCreatePl ? '创建歌单' : '收藏歌单',
                style: body1Style(),
              ),
            ),
          ),
          Gaps.line,
          if (isCreatePl)
            GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.translucent,
              child: Container(
                width: double.infinity,
                height: Dimens.gap_dp50,
                padding: EdgeInsets.only(left: Dimens.gap_dp15),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Image.asset(
                      ImageUtils.getImagePath('icn_newlist'),
                      color: headline2Style().color,
                      width: Dimens.gap_dp26,
                    ),
                    Gaps.hGap10,
                    Text(
                      '新建歌单',
                      style: headline2Style()
                          .copyWith(fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            ),
          GestureDetector(
            onTap: () {
              Get.back();
              Get.toNamed(Routes.PL_MANAGE, arguments: list);
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: double.infinity,
              height: Dimens.gap_dp50,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: Dimens.gap_dp15),
              child: Row(
                children: [
                  Image.asset(
                    ImageUtils.getImagePath('icn_order_change'),
                    color: headline2Style().color,
                    width: Dimens.gap_dp26,
                  ),
                  Gaps.hGap10,
                  Text(
                    '管理歌单',
                    style: headline2Style()
                        .copyWith(fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
