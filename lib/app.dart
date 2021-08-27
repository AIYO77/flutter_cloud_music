import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:flutter_cloud_music/services/event_service.dart';
import 'package:flutter_cloud_music/services/home_top_service.dart';
import 'package:flutter_cloud_music/services/player_service.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/res/colors.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

Widget musicApp() {
  final ThemeData _lightTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colours.bg_color,
      dividerColor: Colours.diver_color,
      iconTheme: const IconThemeData(color: Colours.icon_color),
      highlightColor: Colors.grey.shade300,
      cardColor: Colours.card_color,
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Colors.transparent));
  final ThemeData _darkTheme = ThemeData.dark().copyWith(
      cardColor: Colours.dark_card_color,
      dividerColor: Colours.dark_diver_color,
      iconTheme: const IconThemeData(color: Colours.dark_icon_color),
      highlightColor: Colors.grey.shade300,
      scaffoldBackgroundColor: Colours.dark_bg_color,
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Colors.transparent));
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
        Get.put(PlayerService());
        Get.put(AuthService());
        Get.put(HomeTopService());
        Get.put(EventService());
      }),
      getPages: AppPages.routes,
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
