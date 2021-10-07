import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:flutter_cloud_music/services/event_service.dart';
import 'package:flutter_cloud_music/services/home_top_service.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/res/colors.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

Widget musicApp() {
  final ThemeData _lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colours.bg_color,
    dividerColor: Colours.diver_color,
    shadowColor: Colours.shadow_color,
    // textTheme: TextTheme(
    //     subtitle2: TextStyle(
    //         color: Colours.subtitle_text, fontSize: Dimens.font_sp12)),
    iconTheme: const IconThemeData(color: Colours.icon_color),
    highlightColor: Colors.grey.shade300,
    cardColor: Colours.card_color,
  );
  final ThemeData _darkTheme = ThemeData.dark().copyWith(
    cardColor: Colours.dark_card_color,
    dividerColor: Colours.dark_diver_color,
    iconTheme: const IconThemeData(color: Colours.dark_icon_color),
    highlightColor: Colors.grey.shade300,
    shadowColor: Colours.shadow_color_dark,
    scaffoldBackgroundColor: Colours.dark_bg_color,
    // textTheme: TextTheme(
    //     subtitle2: TextStyle(
    //         color: Colours.dark_subtitle_text, fontSize: Dimens.font_sp12)),
  );
  return RefreshConfiguration(
    headerBuilder: () => const MaterialClassicHeader(
      color: Colours.app_main,
      backgroundColor: Colors.white,
    ),
    child: GetMaterialApp(
      theme: _lightTheme,
      darkTheme: _darkTheme,
      debugShowCheckedModeBanner: false,
      enableLog: kDebugMode,
      logWriterCallback: logWriterCallback,
      initialRoute: Routes.SPLASH,
      color: Colours.bg_color,
      unknownRoute: AppPages.unknownRoute,
      initialBinding: BindingsBuilder(() {
        Get.put(AuthService());
        Get.put(PlayerService());
        Get.put(HomeTopService());
        Get.put(EventService());
      }),
      getPages: AppPages.routes,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CH'),
        Locale('en', 'US'),
      ],
    ),
  );
}

void logWriterCallback(String value, {bool isError = false}) {
  if (Get.isLogEnable) {
    if (isError) {
      logger.e(value);
    } else {
      logger.d(value);
    }
  }
}
