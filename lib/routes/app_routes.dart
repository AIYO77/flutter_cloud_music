import 'package:flutter_cloud_music/common/values/constants.dart';

abstract class Routes {
  Routes._();
  static const ROUTES_HOST = _Paths.ROUTES_HOST;

  static const HOME = _Paths.HOME;
  static const SPLASH = _Paths.SPLASH;
  static const NOT_FOUND = _Paths.NOT_FOUND;

  static const LOGIN = _Paths.LOGIN;
  static const PHONE_LOGIN = _Paths.PHONE_LOGIN;
  static const PWD_LOGIN = _Paths.PWD_LOGIN;
  static const VER_CODE = _Paths.VER_CODE;

  static const FOUND = _Paths.FOUND;
  static const PODCAST = _Paths.PODCAST;
  static const MINE = _Paths.MINE;
  static const K_SONG = _Paths.K_SONG;
  static const CLOUD_VILLAGE = _Paths.CLOUD_VILLAGE;

  static const PLAYLIST_COLLECTION = _Paths.PLAYLIST_COLLECTION;

  static const PLAYLIST_DETAIL = _Paths.PLAYLIST_DETAIL;

  static const PRIVATE_FM = _Paths.PRIVATE_FM;

  static const PLAYING = _Paths.PLAYING;

  static String PLAYLIST_DETAIL_ID(String id) => '/playlist/$id';

  static String LOGIN_THEN(String afterSuccessfulLogin) =>
      '$LOGIN?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';
}

abstract class _Paths {
  static const ROUTES_HOST = '$APP_ROUTER_TAG://';
  static const NOT_FOUND = '/not_found';
  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const PHONE_LOGIN = '$LOGIN/phone_login';
  static const PWD_LOGIN = '$LOGIN/pwd_login';
  static const VER_CODE = '$LOGIN/verification';
  static const FOUND = '/found';
  static const PODCAST = '/podcast';
  static const MINE = '/mine';
  static const K_SONG = '/k_song';
  static const CLOUD_VILLAGE = '/cloud_cillage';
  // 歌单广场
  static const PLAYLIST_COLLECTION = '/playlistCollection';

  //歌单详情 id:歌单ID
  static const PLAYLIST_DETAIL = "/playlist/:id";

  //私人FM播放页面
  static const PRIVATE_FM = "/privatefm";

  //播放页面
  static const PLAYING = "/playing";
}
