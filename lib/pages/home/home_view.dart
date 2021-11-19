import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/pages/cloud_village/cloud_village_view.dart';
import 'package:flutter_cloud_music/pages/found/found_view.dart';
import 'package:flutter_cloud_music/pages/home/widgets/bottom_bar.dart';
import 'package:flutter_cloud_music/pages/home/widgets/drawer.dart';
import 'package:flutter_cloud_music/pages/home/widgets/home_top_bar.dart';
import 'package:flutter_cloud_music/pages/k_song/k_song_view.dart';
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
    return WillPopScope(
        onWillPop: () {
          return _dialogExitApp(context);
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          // appBar: const HomeTopBar(),
          drawer: const DrawerWidget(),
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
                  KeepAliveWrapper(child: KSongPage()),
                  KeepAliveWrapper(child: CloudVillagePage()),
                ],
              )),
              const Positioned(
                top: 0,
                child: HomeTopBar(),
              )
            ],
          ),
          bottomNavigationBar: HomeBottomBar(),
        ));
  }
}
