import 'package:dio/dio.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';

class CookieInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (AuthService.to.isLoggedInValue && AuthService.to.cookie != null) {
      options.queryParameters['cookie'] = AuthService.to.cookie;
    }
    super.onRequest(options, handler);
  }
  // @override
  // Future onRequest(RequestOptions options) {

  //   return super.onRequest(options);
  // }
}
