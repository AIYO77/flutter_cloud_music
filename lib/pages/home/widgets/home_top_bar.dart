import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:get/get.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  final BoxDecoration bgDecoration;
  final Widget child;

  const HomeTopBar({required this.bgDecoration, required this.child});

  @override
  Widget build(BuildContext context) {
    final Widget leading = IconButton(
      icon: Icon(
        Icons.menu,
        size: Dimens.gap_dp24,
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
    );
    return Container(
      decoration: bgDecoration,
      padding: EdgeInsets.only(left: Adapt.px(1.0), right: Adapt.px(10)),
      child: Column(
        // alignment: AlignmentDirectional.centerStart,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: context.mediaQueryPadding.top,
          ),
          Row(
            children: [leading, Expanded(child: child)],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Adapt.px(56));
}
