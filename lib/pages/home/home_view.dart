import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/pages/found/found_view.dart';
import 'package:flutter_cloud_music/pages/home/widgets/bottom_bar.dart';
import 'package:flutter_cloud_music/pages/home/widgets/drawer/drawer.dart';
import 'package:flutter_cloud_music/pages/home/widgets/home_top_bar.dart';
import 'package:flutter_cloud_music/pages/mine/mine_view.dart';
import 'package:flutter_cloud_music/pages/podcast/podcast_view.dart';
import 'package:flutter_cloud_music/widgets/keep_alive_wrapper.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  Future<bool> _dialogExitApp(BuildContext context) async {
    //Android 返回键 退回到桌面 不杀应用
    if (GetPlatform.isAndroid) {
      const intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    Adapt.initContext(context);
    logger.i('isDarkMode =  ${context.isDarkMode}');
    return WillPopScope(
        onWillPop: () {
          return _dialogExitApp(context);
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: context.isDarkMode
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              drawer: DrawerWidget(
                key: const Key('home drawer'),
              ),
              // appBar: AppBar(),
              body: Stack(
                children: [
                  Positioned.fill(
                      child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: controller.changePage,
                    controller: controller.pageController,
                    children: [
                      KeepAliveWrapper(child: FoundPage()),
                      KeepAliveWrapper(child: PodcastPage()),
                      KeepAliveWrapper(child: MinePage()),
                      // KeepAliveWrapper(child: KSongPage()),
                      // KeepAliveWrapper(child: CloudVillagePage()),
                    ],
                  )),
                  const Positioned(
                    top: 0,
                    child: HomeTopBar(),
                  )
                ],
              ),
              bottomNavigationBar: HomeBottomBar(),
            )));
  }
}
