import 'package:flutter_cloud_music/middleware/auth_middleware.dart';
import 'package:flutter_cloud_music/middleware/playing_middleware.dart';
import 'package:flutter_cloud_music/pages/add_song/binding.dart';
import 'package:flutter_cloud_music/pages/add_song/view.dart';
import 'package:flutter_cloud_music/pages/add_video/binding.dart';
import 'package:flutter_cloud_music/pages/add_video/view.dart';
import 'package:flutter_cloud_music/pages/album_detail/album_detail_view.dart';
import 'package:flutter_cloud_music/pages/comment_detail/view.dart';
import 'package:flutter_cloud_music/pages/home/home_binding.dart';
import 'package:flutter_cloud_music/pages/home/home_view.dart';
import 'package:flutter_cloud_music/pages/loading_page/view.dart';
import 'package:flutter_cloud_music/pages/login/email_login/email_login_binding.dart';
import 'package:flutter_cloud_music/pages/login/email_login/email_login_view.dart';
import 'package:flutter_cloud_music/pages/login/login_binding.dart';
import 'package:flutter_cloud_music/pages/login/login_view.dart';
import 'package:flutter_cloud_music/pages/login/phone_login/phone_login_binding.dart';
import 'package:flutter_cloud_music/pages/login/phone_login/phone_login_view.dart';
import 'package:flutter_cloud_music/pages/login/pwd_login/pwd_login_binding.dart';
import 'package:flutter_cloud_music/pages/login/pwd_login/pwd_login_view.dart';
import 'package:flutter_cloud_music/pages/login/verification_code/verification_code_binding.dart';
import 'package:flutter_cloud_music/pages/login/verification_code/verification_code_view.dart';
import 'package:flutter_cloud_music/pages/music_calendar/music_calendar_binding.dart';
import 'package:flutter_cloud_music/pages/music_calendar/music_calendar_view.dart';
import 'package:flutter_cloud_music/pages/new_song_album/new_song_album_binding.dart';
import 'package:flutter_cloud_music/pages/new_song_album/new_song_album_view.dart';
import 'package:flutter_cloud_music/pages/not_found/not_found_binding.dart';
import 'package:flutter_cloud_music/pages/not_found/not_found_view.dart';
import 'package:flutter_cloud_music/pages/pl_manage/pl_manage_binding.dart';
import 'package:flutter_cloud_music/pages/pl_manage/pl_manage_view.dart';
import 'package:flutter_cloud_music/pages/playing/playing_binding.dart';
import 'package:flutter_cloud_music/pages/playing/playing_view.dart';
import 'package:flutter_cloud_music/pages/playing_fm/playing_fm_binding.dart';
import 'package:flutter_cloud_music/pages/playing_fm/playing_fm_view.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/playlist_collection_binding.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/playlist_collection_view.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/selection/binding.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/selection/view.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/playlist_detail_view.dart';
import 'package:flutter_cloud_music/pages/rcmd_song_day/bindings.dart';
import 'package:flutter_cloud_music/pages/rcmd_song_day/view.dart';
import 'package:flutter_cloud_music/pages/search/binding.dart';
import 'package:flutter_cloud_music/pages/search/view.dart';
import 'package:flutter_cloud_music/pages/singer/singer.dart';
import 'package:flutter_cloud_music/pages/singer_detail/view.dart';
import 'package:flutter_cloud_music/pages/single_search/binding.dart';
import 'package:flutter_cloud_music/pages/single_search/view.dart';
import 'package:flutter_cloud_music/pages/splash/splash_binding.dart';
import 'package:flutter_cloud_music/pages/splash/splash_view.dart';
import 'package:flutter_cloud_music/pages/video/binding.dart';
import 'package:flutter_cloud_music/pages/video/view.dart';
import 'package:flutter_cloud_music/pages/web/web_binding.dart';
import 'package:flutter_cloud_music/pages/web/web_view.dart';
import 'package:flutter_cloud_music/widgets/keep_alive_wrapper.dart';
import 'package:get/route_manager.dart';

import '../common/transition/downToUp_with_fade.dart';
import '../middleware/fm_middleware.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBinding(),
      preventDuplicates: true,
      transition: Transition.fade,
    ),

    GetPage(
      name: Routes.HOME,
      page: () => const KeepAliveWrapper(child: HomePage()),
      binding: HomeBinding(),
      preventDuplicates: true,
      transition: Transition.fadeIn,
    ),

    //加载过度页
    GetPage(
      name: Routes.PAGE_MID_LOADING,
      page: () => LoadingPage(),
      preventDuplicates: true,
      opaque: false,
      transition: Transition.noTransition,
    ),

    //歌单广场
    GetPage(
        name: Routes.PLAYLIST_COLLECTION,
        page: () => const PlaylistCollectionPage(),
        binding: PlaylistCollectionBinding(),
        preventDuplicates: true),

    //歌单全部标签
    GetPage(
        name: Routes.PLAYLIST_TAGS,
        page: () => PlaylistTagAllPage(),
        binding: PlaylistTagBinding()),

    //歌单详情
    GetPage(name: Routes.PLAYLIST_DETAIL, page: () => PlaylistDetailPage()),

    //search
    GetPage(
      name: Routes.SEARCH,
      page: () => SearchPage(),
      binding: SearchBinding(),
    ),

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

    //邮箱登陆
    GetPage(
      middlewares: [
        EnsureNotAuthedMiddleware(),
      ],
      name: Routes.EMAIL_LOGIN,
      page: () => const EmailLoginPage(),
      binding: EmailLoginBinding(),
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

    //每日推荐
    GetPage(
        middlewares: [EnsureAuthMiddleware()],
        name: Routes.RCMD_SONG_DAY,
        page: () => const RcmdSongDayPage(),
        binding: RcmdSongDayBinding(),
        transition: Transition.cupertino,
        preventDuplicates: true),

    //私人FM
    GetPage(
      middlewares: [FMMiddleware()],
      name: Routes.PRIVATE_FM,
      page: () => const PlayingFmPage(),
      binding: PlayingFmBinding(),
      customTransition: SlideDownWithFadeTransition(),
      preventDuplicates: true,
    ),

    //playing
    GetPage(
      middlewares: [PlayingMiddleware()],
      name: Routes.PLAYING,
      page: () => const PlayingPage(),
      binding: PlayingBinding(),
      customTransition: SlideDownWithFadeTransition(),
      preventDuplicates: true,
      // preventDuplicates: true,
    ),

    //new song album
    GetPage(
      name: Routes.NEW_SONG_ALBUM,
      page: () => const NewSongAlbumPage(),
      binding: NewSongAlbumBinding(),
      transition: Transition.rightToLeft,
    ),

    //album detail
    GetPage(
      name: Routes.ALBUM_DETAIL,
      page: () => AlbumDetailPage(),
      transition: Transition.rightToLeft,
    ),

    //Music Calendar
    GetPage(
        middlewares: [EnsureAuthMiddleware()],
        name: Routes.MUSIC_CALENDAR,
        page: () => const MusicCalendarPage(),
        binding: MusicCalendarBinding(),
        transition: Transition.rightToLeft),

    //Singer
    GetPage(
        name: Routes.SINGER_PAGE,
        page: () => SingerPage(),
        transition: Transition.rightToLeft),

    //singer detail
    GetPage(
        name: Routes.SINGER_DETAIL,
        page: () => SingerDetailPage(),
        preventDuplicates: false,
        transition: Transition.rightToLeft),

    //歌单管理
    GetPage(
        name: Routes.PL_MANAGE,
        page: () => const PlManagePage(),
        binding: PlManageBinding(),
        preventDuplicates: true,
        transition: Transition.downToUp),

    //添加歌曲
    GetPage(
        name: Routes.ADD_SONG,
        page: () => AddSongPage(),
        binding: AddSongBinding(),
        transition: Transition.downToUp),

    //添加视频
    GetPage(
        name: Routes.ADD_VIDEO,
        page: () => AddVideoPage(),
        binding: AddVideoBinding(),
        transition: Transition.downToUp),

    //单一搜索（目前添加歌曲和添加视频用到）
    GetPage(
        name: Routes.SINGLE_SEARCH,
        page: () => SingleSearchPage(),
        binding: SingleSearchBinding(),
        transition: Transition.fadeIn),

    //视频播放页面
    GetPage(
        name: Routes.VIDEO_PLAY,
        page: () => VideoPage(),
        binding: VideoBinding(),
        transition: Transition.rightToLeft),

    //评论详情
    GetPage(
      name: Routes.COMMENT_DETAIL,
      page: () => CommentDetailPage(),
    ),

    //web
    GetPage(
        name: Routes.WEB,
        page: () => const WebPage(),
        binding: WebBinding(),
        preventDuplicates: true),
  ];

  //未知路由
  static final unknownRoute = GetPage(
      name: Routes.NOT_FOUND,
      page: () => const NotFoundPage(),
      binding: NotFoundBinding());
}
