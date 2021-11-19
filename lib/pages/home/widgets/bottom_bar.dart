import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/player/widgets/bottom_player_widget.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/home/home_controller.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:get/get.dart';

class HomeBottomBar extends StatelessWidget {
  final controller = Get.find<HomeController>();

  Widget _getBarIcon(int index, bool isActive) {
    String path;
    if (index == 0) {
      path = 'icn_discovery';
    } else if (index == 1) {
      path = 'icn_radio';
    } else if (index == 2) {
      path = 'icn_music_new';
    } else if (index == 3) {
      path = 'icn_friend';
    } else {
      path = 'icn_radio_new';
    }

    return ClipOval(
      child: Container(
        width: Dimens.gap_dp25,
        height: Dimens.gap_dp25,
        padding: EdgeInsets.all(Dimens.gap_dp3),
        decoration: isActive
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: Get.isDarkMode
                      ? Alignment.bottomLeft
                      : Alignment.topRight,
                  end: Get.isDarkMode
                      ? Alignment.topRight
                      : Alignment.bottomLeft,
                  colors: [
                    Colours.app_main_light.withOpacity(0.8),
                    Colours.app_main_light.withOpacity(0.9),
                    Colours.app_main_light
                  ],
                ),
              )
            : null,
        child: Image.asset(
          ImageUtils.getImagePath(path),
          color: isActive ? Colors.white : Colours.color_189,
        ),
      ),
    );
  }

  Text _getBarText(int index) {
    if (index == 0) {
      return Text("发现", style: TextStyle(fontSize: Dimens.font_sp11));
    } else if (index == 1) {
      return Text("播客", style: TextStyle(fontSize: Dimens.font_sp11));
    } else if (index == 2) {
      return Text("我的", style: TextStyle(fontSize: Dimens.font_sp11));
    } else if (index == 3) {
      return Text("关注", style: TextStyle(fontSize: Dimens.font_sp11));
    } else {
      return Text("云村", style: TextStyle(fontSize: Dimens.font_sp11));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Dimens.gap_dp48),
          child: BottomPlayerBar(),
        ),
        Obx(
          () => BottomBar(
            currentIndex: controller.currentIndex.value,
            focusColor: Colours.app_main_light,
            height: Dimens.gap_dp50,
            unFocusColor: Colours.color_189,
            onTap: controller.changePage,
            items: List<BottomBarItem>.generate(
              5,
              (index) => BottomBarItem(
                icon: _getBarIcon(index, false),
                title: _getBarText(index),
                activeIcon: _getBarIcon(index, true),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class BottomBar extends StatefulWidget {
  final List<BottomBarItem> items;
  final int currentIndex;
  final double height;
  final Color focusColor;
  final Color unFocusColor;
  final ValueChanged<int> onTap;

  const BottomBar({
    required this.items,
    this.currentIndex = 0,
    required this.height,
    required this.focusColor,
    required this.unFocusColor,
    required this.onTap,
  });

  @override
  __BottomBarState createState() => __BottomBarState();
}

class __BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < widget.items.length; i += 1) {
      children.add(_createItem(i));
    }

    return SizedBox(
      height: widget.height + Adapt.bottomPadding(),
      width: Adapt.screenW(),
      child: Stack(
        children: [
          //背景
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Get.theme.cardColor.withOpacity(0.85),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Adapt.bottomPadding(),
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children,
            ),
          )
        ],
      ),
    );
  }

  Widget _createItem(int i) {
    final BottomBarItem item = widget.items[i];
    final bool selected = i == widget.currentIndex;
    return Expanded(
        child: SizedBox(
      height: widget.height,
      child: InkResponse(
        onTap: () async {
          widget.onTap(i);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (selected) item.activeIcon else item.icon,
              DefaultTextStyle.merge(
                  style: TextStyle(
                    color: selected ? widget.focusColor : widget.unFocusColor,
                  ),
                  child: item.title),
            ],
          ),
        ),
      ),
    ));
  }
}

class BottomBarItem {
  final Widget icon;
  final Widget activeIcon;
  final Widget title;

  BottomBarItem(
      {required this.icon, required this.title, required this.activeIcon});
}
