import 'package:flutter/material.dart';

import 'colors.dart';

class Themes {
  static final lightTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colours.bg_color,
      dividerColor: Colours.diver_color,
      shadowColor: Colours.shadow_color,
      iconTheme: const IconThemeData(color: Colours.icon_color),
      highlightColor: Colors.grey.shade300,
      cardColor: Colours.card_color,
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
          caption: TextStyle(color: Colours.subtitle_text, fontSize: 12)));

  static final darkTheme = ThemeData.dark().copyWith(
    cardColor: Colours.dark_card_color,
    dividerColor: Colours.dark_diver_color,
    iconTheme: IconThemeData(color: Colours.dark_icon_color),
    highlightColor: Colors.grey.shade300.withOpacity(0.5),
    shadowColor: Colours.shadow_color_dark,
    scaffoldBackgroundColor: Colours.dark_bg_color,
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
        caption: TextStyle(color: Colours.dark_subtitle_text, fontSize: 12)),
  );
}
