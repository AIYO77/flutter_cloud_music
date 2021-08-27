import 'package:flutter_cloud_music/common/values/constants.dart';

abstract class Routes {
  Routes._();
  static const ROUTES_HOST = _Paths.ROUTES_HOST;

  static const HOME = _Paths.HOME;
  static const SPLASH = _Paths.SPLASH;
  static const NOT_FOUND = _Paths.NOT_FOUND;

  static const LOGIN = _Paths.LOGIN;
  static const FOUND = _Paths.FOUND;
  static const PODCAST = _Paths.PODCAST;
  static const MINE = _Paths.MINE;
  static const K_SONG = _Paths.K_SONG;
  static const CLOUD_VILLAGE = _Paths.CLOUD_VILLAGE;

  static const PLAYLIST_COLLECTION = _Paths.PLAYLIST_COLLECTION;

  static String LOGIN_THEN(String afterSuccessfulLogin) =>
      '$LOGIN?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';
}

abstract class _Paths {
  static const ROUTES_HOST = '$APP_ROUTER_TAG://';
  static const NOT_FOUND = '/not_found';
  static const SPLASH = '/${ROUTES_HOST}splash';
  static const HOME = '/${ROUTES_HOST}home';
  static const LOGIN = '/${ROUTES_HOST}login';
  static const FOUND = '/${ROUTES_HOST}found';
  static const PODCAST = '/${ROUTES_HOST}podcast';
  static const MINE = '/${ROUTES_HOST}mine';
  static const K_SONG = '/${ROUTES_HOST}k_song';
  static const CLOUD_VILLAGE = '/${ROUTES_HOST}cloud_cillage';
  // 歌单广场
  static const PLAYLIST_COLLECTION = '/${ROUTES_HOST}playlistCollection';
}
