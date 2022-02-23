import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/pages/singer_detail/logic.dart';
import 'package:get/get.dart';

class SingerTabs extends StatefulWidget {
  final SingerDetailLogic controller;

  const SingerTabs(this.controller);

  @override
  _SingerTabsState createState() => _SingerTabsState();
}

class _SingerTabsState extends State<SingerTabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.cardColor,
      height: Dimens.gap_dp40,
      child: TabBar(
        labelPadding: EdgeInsets.zero,
        padding: EdgeInsets.only(top: Dimens.gap_dp4),
        labelColor: Get.isDarkMode
            ? Colors.white
            : const Color.fromARGB(255, 51, 51, 51),
        labelStyle:
            TextStyle(fontSize: Dimens.font_sp15, fontWeight: FontWeight.w500),
        unselectedLabelColor: Get.isDarkMode
            ? Colors.white.withOpacity(0.8)
            : const Color.fromARGB(255, 114, 114, 114),
        unselectedLabelStyle: TextStyle(
            fontSize: Dimens.font_sp15, fontWeight: FontWeight.normal),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.only(
            // left: Dimens.gap_dp5,
            bottom: Dimens.gap_dp9,
            top: Dimens.gap_dp21),
        indicator: BoxDecoration(
            color: Colours.indicator_color,
            borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp10))),
        controller: widget.controller.state.tabController,
        onTap: (index) {},
        tabs: tabsWidget(),
      ),
    );
  }

  List<Widget> tabsWidget() {
    return widget.controller.state.tabs!
        .map((e) => Tab(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(e.title),
                  if ((e.num ?? 0) > 0)
                    Padding(
                      padding: EdgeInsets.only(
                          top: Dimens.gap_dp2, left: Dimens.gap_dp1),
                      child: Text(
                        e.num! >= 1000 ? '999+' : e.num.toString(),
                        style: TextStyle(fontSize: Dimens.font_sp9),
                      ),
                    )
                ],
              ),
            ))
        .toList();
  }
}
