import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/add_video/widget/video_list.dart';
import 'package:flutter_cloud_music/widgets/keep_alive_wrapper.dart';
import 'package:get/get.dart';

import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';
import '../../common/res/gaps.dart';
import '../../common/utils/common_utils.dart';
import '../../common/values/constants.dart';
import '../../routes/app_routes.dart';
import 'logic.dart';

class AddVideoPage extends GetView<AddVideoLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      appBar: AppBar(
        title: const Text('添加视频到歌单'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              height: context.theme.appBarTheme.toolbarHeight ?? 44,
              padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
              alignment: Alignment.center,
              child: Text(
                '完成',
                style: body2Style(),
              ),
            ),
          )
        ],
        bottom: _buildBottom(context),
      ),
      body: TabBarView(controller: controller.tabController, children: [
        KeepAliveWrapper(child: AddVideoListView('like')),
        KeepAliveWrapper(child: AddVideoListView('resend')),
      ]),
    );
  }

  PreferredSizeWidget _buildBottom(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(Dimens.gap_dp95),
        child: Container(
          height: Dimens.gap_dp95,
          margin: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
          child: Column(
            children: [
              Gaps.vGap4,
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.SINGLE_SEARCH, arguments: SEARCH_VIDEOS);
                },
                child: Hero(
                  tag: SINGLE_SEARCH,
                  child: Container(
                    height: Dimens.gap_dp38,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.isDarkMode
                          ? Colors.white12
                          : Colours.color_245,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimens.gap_dp18),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: Colours.color_156,
                          size: Dimens.gap_dp20,
                        ),
                        Gaps.hGap3,
                        Text('搜索视频',
                            style: TextStyle(
                                fontSize: Dimens.font_sp14,
                                color: Colours.text_gray))
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: TabBar(
                labelPadding: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                labelColor: Get.isDarkMode
                    ? Colors.white
                    : const Color.fromARGB(255, 51, 51, 51),
                labelStyle: TextStyle(
                    fontSize: Dimens.font_sp16, fontWeight: FontWeight.w500),
                unselectedLabelColor: Get.isDarkMode
                    ? Colors.white.withOpacity(0.8)
                    : const Color.fromARGB(255, 114, 114, 114),
                unselectedLabelStyle: TextStyle(
                    fontSize: Dimens.font_sp16, fontWeight: FontWeight.normal),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(
                    bottom: Dimens.gap_dp16, top: Dimens.gap_dp30),
                indicator: BoxDecoration(
                    color: Colours.indicator_color,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.gap_dp10))),
                controller: controller.tabController,
                tabs: const [
                  Tab(
                    text: '我赞过的',
                  ),
                  Tab(
                    text: '最近播放',
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
