import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:get/get.dart';

import 'colors.dart';

class Themes {
  static final lightTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colours.bg_color,
      dividerColor: Colours.diver_color,
      shadowColor: Colours.shadow_color,
      iconTheme: const IconThemeData(color: Colours.icon_color),
      highlightColor: Colours.blue,
      hintColor: Colors.grey.shade300,
      cardColor: Colours.card_color,
      appBarTheme: const AppBarTheme(
          toolbarHeight: 56.0,
          backgroundColor: Colours.card_color,
          titleTextStyle: TextStyle(
              color: Colours.body2_txt_color,
              fontSize: 17.0,
              fontWeight: FontWeight.w600),
          elevation: 0),
      dialogTheme: const DialogTheme(
          backgroundColor: Colors.black87,
          elevation: 24.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14.0)))),
      textTheme: const TextTheme(
          headline1: TextStyle(
              color: Colours.headline1_color,
              fontSize: 13,
              fontWeight: FontWeight.w500),
          headline2: TextStyle(
              color: Colours.headline1_color,
              fontSize: 15,
              fontWeight: FontWeight.w500),
          subtitle1: TextStyle(
              color: Colours.headline4_color,
              fontSize: 17,
              fontWeight: FontWeight.w600),
          bodyText1: TextStyle(
              color: Colours.body1_txt_color,
              fontSize: 13,
              fontWeight: FontWeight.normal),
          bodyText2: TextStyle(
              color: Colours.body2_txt_color,
              fontSize: 16,
              fontWeight: FontWeight.normal),
          caption: TextStyle(color: Colours.subtitle_text, fontSize: 12)));

  static final darkTheme = ThemeData.dark().copyWith(
    cardColor: Colours.dark_card_color,
    dividerColor: Colours.dark_diver_color,
    iconTheme: IconThemeData(color: Colours.dark_icon_color),
    highlightColor: Colours.blue_dark,
    hintColor: Colors.grey.shade300.withOpacity(0.5),
    shadowColor: Colours.shadow_color_dark,
    scaffoldBackgroundColor: Colours.dark_bg_color,
    appBarTheme: AppBarTheme(
        toolbarHeight: 56.0,
        backgroundColor: Colours.dark_card_color,
        titleTextStyle: TextStyle(
            color: Colours.dark_body2_txt_color,
            fontSize: 17.0,
            fontWeight: FontWeight.w600),
        elevation: 0),
    dialogTheme: const DialogTheme(
        backgroundColor: Colors.black,
        elevation: 24.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0)))),
    textTheme: TextTheme(
        headline1: const TextStyle(
            color: Colours.dark_headline1_color,
            fontSize: 13,
            fontWeight: FontWeight.w500),
        headline2: const TextStyle(
            color: Colours.dark_headline1_color,
            fontSize: 15,
            fontWeight: FontWeight.w500),
        subtitle1: const TextStyle(
            color: Colours.dark_headline4_color,
            fontSize: 17,
            fontWeight: FontWeight.w600),
        bodyText1: TextStyle(color: Colours.dark_body1_txt_color, fontSize: 13),
        bodyText2: TextStyle(
            color: Colours.dark_body2_txt_color,
            fontSize: 16,
            fontWeight: FontWeight.normal),
        caption: TextStyle(color: Colours.dark_subtitle_text, fontSize: 12)),
  );

  static Future<void> setThemeModeIsLight(ThemeMode mode) async {
    await box.write('isLight', mode == ThemeMode.light);
  }

  static ThemeMode themeMode() {
    final isLight = box.read<bool>('isLight');
    return isLight == null
        ? ThemeMode.system
        : isLight
            ? ThemeMode.light
            : ThemeMode.dark;
  }

  static Future<void> changeTheme() async {
    final mode = Get.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await setThemeModeIsLight(mode);
    Get.changeThemeMode(mode);
  }
}
