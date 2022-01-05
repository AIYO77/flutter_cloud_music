import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/widgets/bottom_player_widget.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/pages/music_calendar/content/calendar_list_view.dart';
import 'package:flutter_cloud_music/widgets/keep_alive_wrapper.dart';
import 'package:flutter_cloud_music/widgets/my_app_bar.dart';
import 'package:get/get.dart';

import 'music_calendar_controller.dart';

class MusicCalendarPage extends GetView<MusicCalendarController> {
  const MusicCalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
      appBar: const MyAppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        centerTitle: '音乐日历',
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(236, 100, 84, 0.95),
              Color.fromRGBO(233, 60, 43, 1.0)
            ],
          ),
        ),
        child: BottomPlayerController(Container(
          margin: EdgeInsets.only(
              top: Dimens.gap_dp44 + context.mediaQueryPadding.top),
          width: Adapt.screenW(),
          height: Adapt.screenH(),
          child: Column(
            children: [
              SizedBox(
                width: Adapt.screenW(),
                height: Dimens.gap_dp42,
                child: _buildTab(),
              ),
              Expanded(
                  child: Container(
                width: Adapt.screenW(),
                decoration: BoxDecoration(
                    color: Get.theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimens.gap_dp15),
                        topLeft: Radius.circular(Dimens.gap_dp15))),
                child: _buildPageView(),
              ))
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildTab() {
    return TabBar(
      labelColor: Colors.white,
      labelStyle:
          TextStyle(fontSize: Dimens.font_sp17, fontWeight: FontWeight.w500),
      unselectedLabelColor: Colors.white.withOpacity(0.25),
      unselectedLabelStyle:
          TextStyle(fontSize: Dimens.font_sp16, fontWeight: FontWeight.normal),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Colors.transparent,
      controller: controller.tabController,
      onTap: controller.changeTab,
      tabs: controller.getTabs(),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildPage(context, index);
      },
      itemCount: controller.dates.length,
      controller: controller.pageController,
      onPageChanged: controller.pageChanged,
    );
  }

  Widget _buildPage(BuildContext context, int index) {
    final date = controller.dates.elementAt(index);
    return KeepAliveWrapper(
        child: CalenderListView(
      Key('$index'),
      dateTime: date,
    ));
  }
}
