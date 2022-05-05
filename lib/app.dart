import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/res/themes.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:flutter_cloud_music/services/event_service.dart';
import 'package:flutter_cloud_music/services/stored_service.dart';
import 'package:flutter_cloud_music/widgets/footer_loading.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/res/colors.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

Widget musicApp() {
  return RefreshConfiguration(
    headerBuilder: () => const MaterialClassicHeader(
      color: Colours.app_main,
      backgroundColor: Colors.white,
    ),
    footerBuilder: () => const FooterLoading(),
    child: FlutterEasyLoading(
      child: GetMaterialApp(
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: Themes.themeMode(),
        debugShowCheckedModeBanner: false,
        logWriterCallback: logWriterCallback,
        initialRoute: Routes.SPLASH,
        color: Colours.bg_color,
        unknownRoute: AppPages.unknownRoute,
        initialBinding: BindingsBuilder(() {
          Get.put(AuthService());
          Get.put(PlayerService());
          Get.put(EventService());
          Get.put(StoredService());
        }),
        getPages: AppPages.routes,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        builder: (context, widget) {
          return Stack(
            children: [
              widget!,
              //黑夜模式 添加一个蒙层
              if (context.isDarkMode)
                IgnorePointer(
                  child: Container(
                    color: Colors.black12,
                  ),
                )
            ],
          );
        },
        // supportedLocales: const [
        //   Locale('zh', 'CH'),
        //   Locale('en', 'US'),
        // ],
      ),
    ),
  );
}

void logWriterCallback(String value, {bool isError = false}) {
  if (Get.isLogEnable) {
    if (isError) {
      toast(value);
      logger.e(value);
    } else {
      logger.d(value);
    }
  }
}
