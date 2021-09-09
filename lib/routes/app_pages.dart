import 'package:flutter_cloud_music/middleware/auth_middleware.dart';
import 'package:flutter_cloud_music/pages/cloud_village/cloud_village_binding.dart';
import 'package:flutter_cloud_music/pages/cloud_village/cloud_village_view.dart';
import 'package:flutter_cloud_music/pages/found/found_binding.dart';
import 'package:flutter_cloud_music/pages/found/found_view.dart';
import 'package:flutter_cloud_music/pages/home/home_binding.dart';
import 'package:flutter_cloud_music/pages/home/home_view.dart';
import 'package:flutter_cloud_music/pages/k_song/k_song_binding.dart';
import 'package:flutter_cloud_music/pages/k_song/k_song_view.dart';
import 'package:flutter_cloud_music/pages/login/login_binding.dart';
import 'package:flutter_cloud_music/pages/login/login_view.dart';
import 'package:flutter_cloud_music/pages/mine/mine_binding.dart';
import 'package:flutter_cloud_music/pages/mine/mine_view.dart';
import 'package:flutter_cloud_music/pages/not_found/not_found_binding.dart';
import 'package:flutter_cloud_music/pages/not_found/not_found_view.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/playlist_collection_binding.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/playlist_collection_view.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/playlist_detail_binding.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/playlist_detail_view.dart';
import 'package:flutter_cloud_music/pages/podcast/podcast_binding.dart';
import 'package:flutter_cloud_music/pages/podcast/podcast_view.dart';
import 'package:flutter_cloud_music/pages/splash/splash_binding.dart';
import 'package:flutter_cloud_music/pages/splash/splash_view.dart';
import 'package:get/route_manager.dart';

import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
        name: Routes.SPLASH,
        page: () => const SplashPage(),
        binding: SplashBinding(),
        preventDuplicates: true,
        transition: Transition.fade),

    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
      preventDuplicates: true,
      transition: Transition.fadeIn,
      children: [
        GetPage(
            name: Routes.FOUND,
            page: () => FoundPage(),
            binding: FoundBinding()),
        GetPage(
            name: Routes.PODCAST,
            page: () => const PodcastPage(),
            binding: PodcastBinding()),
        GetPage(
            name: Routes.MINE,
            page: () => const MinePage(),
            binding: MineBinding()),
        GetPage(
            name: Routes.K_SONG,
            page: () => const KSongPage(),
            binding: KSongBinding()),
        GetPage(
            name: Routes.CLOUD_VILLAGE,
            page: () => const CloudVillagePage(),
            binding: CloudVillageBinding()),
      ],
    ),

    //歌单广场
    GetPage(
        name: Routes.PLAYLIST_COLLECTION,
        page: () => const PlaylistCollectionPage(),
        binding: PlaylistCollectionBinding(),
        preventDuplicates: true),

    //歌单详情
    GetPage(
        name: Routes.PLAYLIST_DETAIL,
        page: () => PlaylistDetailPage(),
        binding: PlaylistDetailBinding()),

    // login
    GetPage(
      middlewares: [
        EnsureNotAuthedMiddleware(),
      ],
      name: Routes.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.downToUp,
      preventDuplicates: true,
    ),
  ];

  //未知路由
  static final unknownRoute = GetPage(
      name: Routes.NOT_FOUND,
      page: () => const NotFoundPage(),
      binding: NotFoundBinding());
}
