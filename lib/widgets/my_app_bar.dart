/*
 * @Author: XingWei 
 * @Date: 2021-07-23 10:15:43 
 * @Last Modified by: XingWei
 * @Last Modified time: 2021-12-13 19:55:01
 * 
 * 自定义AppBar
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
      {Key? key,
      this.backgroundColor,
      this.foregroundColor,
      this.title = '',
      this.centerTitle = '',
      this.backImg = 'assets/images/dij.png',
      this.onPressed,
      this.isBack = true})
      : super(key: key);

  final Color? backgroundColor;
  final Color? foregroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final VoidCallback? onPressed;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    final _backgroundColor = backgroundColor ?? Get.theme.cardColor;

    final _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    final _foregroundColor = foregroundColor ??
        (Get.isDarkMode ? Colours.white.withOpacity(0.9) : Colors.black);

    final back = isBack
        ? IconButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              if (onPressed != null) {
                onPressed!.call();
              } else {
                Get.back();
              }
            },
            // tooltip: 'Back',
            padding: const EdgeInsets.only(left: 12.0),
            icon: Image.asset(
              backImg,
              color: _foregroundColor,
              width: Dimens.gap_dp25,
              height: Dimens.gap_dp25,
            ),
          )
        : Gaps.empty;

    final Widget titleWidget = Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment:
            centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 44),
        child: Text(
          title.isEmpty ? centerTitle : title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: _foregroundColor,
              fontSize: Dimens.font_sp16,
              fontWeight: FontWeight.w600),
        ),
      ),
    );

    // final Widget line = Positioned(
    //     top: 12,
    //     child: );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              titleWidget,
              back,
              // line,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimens.gap_dp44);
}
