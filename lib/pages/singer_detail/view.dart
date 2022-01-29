import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/delegate/general_sliver_delegate.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widget/singer_header.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:flutter_cloud_music/widgets/my_app_bar.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class SingerDetailPage extends StatelessWidget {
  late SingerDetailLogic logic;

  late SingerDetailState state;

  @override
  Widget build(BuildContext context) {
    logic = Get.put(SingerDetailLogic(),
        tag: (Get.arguments['accountId'] ?? Get.arguments['artistId'])
            .toString());
    state = logic.state;
    return Obx(
      () => Scaffold(
          extendBodyBehindAppBar: true,
          appBar: MyAppBar(
            key: state.barKey,
            title: state.isPinned.value ? state.getName() : '',
            foregroundColor: state.isPinned.value
                ? Get.theme.appBarTheme.titleTextStyle?.color
                : Colors.white,
            backgroundColor: false ? Get.theme.cardColor : Colors.transparent,
          ),
          body: state.detail.value == null ? _buildLoading() : _buildBody()),
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      controller: state.scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: SingerHeader(logic),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Dimens.gap_dp12,
          ),
        ),
        SliverPersistentHeader(
            pinned: true,
            delegate: GeneralSliverDelegate(
                child: PreferredSize(
              preferredSize: Size.fromHeight(Dimens.gap_dp40),
              child: Container(
                height: Dimens.gap_dp40,
                child: Container(
                  key: state.tabKey,
                  color: Colors.red,
                ),
              ),
            ))),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return ListTile(
            title: Text('item $index'),
          );
        }, childCount: 30))
      ],
    );
  }

  Widget _buildLoading() {
    return Container(
      padding: EdgeInsets.only(top: Adapt.screenH() / 2 - Adapt.topPadding()),
      alignment: Alignment.center,
      child: MusicLoading(),
    );
  }
}
