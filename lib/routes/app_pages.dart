import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/middleware/auth_middleware.dart';
import 'package:flutter_cloud_music/middleware/playing_middleware.dart';
import 'package:flutter_cloud_music/pages/home/home_binding.dart';
import 'package:flutter_cloud_music/pages/home/home_view.dart';
import 'package:flutter_cloud_music/pages/login/login_binding.dart';
import 'package:flutter_cloud_music/pages/login/login_view.dart';
import 'package:flutter_cloud_music/pages/login/phone_login/phone_login_binding.dart';
import 'package:flutter_cloud_music/pages/login/phone_login/phone_login_view.dart';
import 'package:flutter_cloud_music/pages/login/pwd_login/pwd_login_binding.dart';
import 'package:flutter_cloud_music/pages/login/pwd_login/pwd_login_view.dart';
import 'package:flutter_cloud_music/pages/login/verification_code/verification_code_binding.dart';
import 'package:flutter_cloud_music/pages/login/verification_code/verification_code_view.dart';
import 'package:flutter_cloud_music/pages/not_found/not_found_binding.dart';
import 'package:flutter_cloud_music/pages/not_found/not_found_view.dart';
import 'package:flutter_cloud_music/pages/playing/playing_binding.dart';
import 'package:flutter_cloud_music/pages/playing/playing_view.dart';
import 'package:flutter_cloud_music/pages/playing_fm/playing_fm_binding.dart';
import 'package:flutter_cloud_music/pages/playing_fm/playing_fm_view.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/playlist_collection_binding.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/playlist_collection_view.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/playlist_detail_binding.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/playlist_detail_view.dart';
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

    //手机登陆
    GetPage(
      middlewares: [
        EnsureNotAuthedMiddleware(),
      ],
      name: Routes.PHONE_LOGIN,
      page: () => const PhoneLoginPage(),
      binding: PhoneLoginBinding(),
      transition: Transition.cupertino,
      preventDuplicates: true,
    ),

    //密码登陆
    GetPage(
      middlewares: [
        EnsureNotAuthedMiddleware(),
      ],
      name: Routes.PWD_LOGIN,
      page: () => const PwdLoginPage(),
      binding: PwdLoginBinding(),
      transition: Transition.cupertino,
      preventDuplicates: true,
    ),

    //验证码
    GetPage(
      name: Routes.VER_CODE,
      page: () => const VerificationCodePage(),
      binding: VerificationCodeBinding(),
      transition: Transition.cupertino,
      preventDuplicates: true,
    ),

    //私人FM
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: Routes.PRIVATE_FM,
      page: () => const PlayingFmPage(),
      binding: PlayingFmBinding(),
      transition: Transition.downToUp,
      preventDuplicates: true,
    ),

    //playing
    GetPage(
      middlewares: [PlayingMiddleware()],
      name: Routes.PLAYING,
      page: () => const PlayingPage(),
      binding: PlayingBinding(),
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
