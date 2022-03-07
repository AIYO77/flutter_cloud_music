import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:get/get.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget leading = IconButton(
      icon: Icon(
        Icons.menu_sharp,
        size: Dimens.gap_dp24,
        color: context.isDarkMode
            ? Colours.dark_body2_txt_color
            : Colours.body2_txt_color,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
    );
    return Container(
      // decoration: bgDecoration,
      color: Colors.transparent,
      padding: EdgeInsets.only(left: Adapt.px(2), right: Adapt.px(10)),
      margin: EdgeInsets.only(top: context.mediaQueryPadding.top),
      child: SizedBox(
        height: Get.theme.appBarTheme.toolbarHeight,
        child: leading,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Adapt.px(56));
}
