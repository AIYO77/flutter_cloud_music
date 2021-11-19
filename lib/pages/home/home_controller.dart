import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/cloud_village/cloud_village_binding.dart';
import 'package:flutter_cloud_music/pages/cloud_village/cloud_village_view.dart';
import 'package:flutter_cloud_music/pages/found/found_binding.dart';
import 'package:flutter_cloud_music/pages/found/found_view.dart';
import 'package:flutter_cloud_music/pages/k_song/k_song_binding.dart';
import 'package:flutter_cloud_music/pages/k_song/k_song_view.dart';
import 'package:flutter_cloud_music/pages/mine/mine_binding.dart';
import 'package:flutter_cloud_music/pages/mine/mine_view.dart';
import 'package:flutter_cloud_music/pages/podcast/podcast_binding.dart';
import 'package:flutter_cloud_music/pages/podcast/podcast_view.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/widgets/keep_alive_wrapper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;

  final pageController = PageController();

  final pages = <String>[
    Routes.FOUND,
    Routes.PODCAST,
    Routes.MINE,
    Routes.K_SONG,
    Routes.CLOUD_VILLAGE
  ];

  @override
  void onClose() {}

  void changePage(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
    // Get.toNamed(pages[index], id: 1);
    // HomeTopService.to.homePagechanged(index);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.FOUND) {
      return GetPageRoute(
          settings: settings,
          page: () => KeepAliveWrapper(child: FoundPage()),
          binding: FoundBinding(),
          transition: Transition.noTransition);
    } else if (settings.name == Routes.PODCAST) {
      return GetPageRoute(
          settings: settings,
          page: () => KeepAliveWrapper(child: PodcastPage()),
          binding: PodcastBinding(),
          transition: Transition.noTransition);
    } else if (settings.name == Routes.MINE) {
      return GetPageRoute(
          settings: settings,
          page: () => KeepAliveWrapper(child: MinePage()),
          binding: MineBinding(),
          transition: Transition.noTransition);
    } else if (settings.name == Routes.K_SONG) {
      return GetPageRoute(
          settings: settings,
          page: () => KeepAliveWrapper(child: KSongPage()),
          binding: KSongBinding(),
          transition: Transition.noTransition);
    } else if (settings.name == Routes.CLOUD_VILLAGE) {
      return GetPageRoute(
          settings: settings,
          page: () => KeepAliveWrapper(child: CloudVillagePage()),
          binding: CloudVillageBinding(),
          transition: Transition.noTransition);
    }

    return null;
  }
}
