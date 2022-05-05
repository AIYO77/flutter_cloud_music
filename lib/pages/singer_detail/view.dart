import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/widgets/bottom_player_widget.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/delegate/general_sliver_delegate.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widget/singer_header.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widget/singer_tabs.dart';
import 'package:flutter_cloud_music/widgets/follow/follow_widget.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class SingerDetailPage extends StatelessWidget {
  late SingerDetailLogic logic;
  late SingerDetailState state;

  String? _accountId;
  String? _artistId;

  @override
  Widget build(BuildContext context) {
    if (_accountId == null && _artistId == null) {
      _accountId = Get.arguments['accountId']?.toString();
      _artistId = Get.arguments['artistId']?.toString();
    }
    logic = Get.put(
        SingerDetailLogic()
          ..state.artistId = _artistId
          ..state.accountId.value = _accountId,
        tag: (_accountId ?? _artistId).toString());
    state = logic.state;
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Get.theme.cardColor,
        body: BottomPlayerController(Obx(() =>
            state.detail.value == null ? _buildLoading() : _buildBody())));
  }

  Widget _buildBody() {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            Obx(() => SliverAppBar(
                  expandedHeight:
                      Adapt.px(state.accountId.value == null ? 368 : 421) +
                          state.animValue.value * Adapt.px(152),
                  toolbarHeight: Dimens.gap_dp44,
                  collapsedHeight: Dimens.gap_dp44,
                  pinned: true,
                  backgroundColor: Get.theme.cardColor,
                  automaticallyImplyLeading: false,
                  leading: leading,
                  title: state.isPinned.value ? Text(state.getName()) : null,
                  titleTextStyle: Get.theme.appBarTheme.titleTextStyle,
                  centerTitle: false,
                  actions: [
                    if (state.isPinned.value)
                      Container(
                        margin: EdgeInsets.only(right: Dimens.gap_dp16),
                        padding: EdgeInsets.symmetric(vertical: Dimens.gap_dp9),
                        child: SizedBox(
                          height: Dimens.gap_dp26,
                          width: Dimens.gap_dp60,
                          child: FollowWidget(Key(state.getUserId().toString()),
                              id: state.getUserId().toString(),
                              isSolidWidget: true,
                              isSinger: state.isSinger(),
                              isFollowed: state.isFollow()),
                        ),
                      )
                  ],
                  elevation: 0.0,
                  flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                    Future.delayed(const Duration(milliseconds: 10))
                        .then((value) {
                      state.isPinned.value = constraints.biggest.height <=
                          (Adapt.topPadding() + Dimens.gap_dp44);
                    });
                    return FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: SingerHeader(logic),
                    );
                  }),
                )),
            SliverToBoxAdapter(
              child: Gaps.vGap10,
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: GeneralSliverDelegate(
                  child: PreferredSize(
                preferredSize: Size.fromHeight(Dimens.gap_dp40),
                child: SingerTabs(logic),
              )),
            )
          ];
        },
        body: TabBarView(
            controller: state.tabController, children: logic.getTabBarViews()));
  }

  Widget _buildLoading() {
    return Container(
      padding: EdgeInsets.only(top: Adapt.screenH() / 2 - Adapt.topPadding()),
      alignment: Alignment.center,
      child: MusicLoading(),
    );
  }
}
