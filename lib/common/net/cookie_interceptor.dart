import 'package:dio/dio.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';

class CookieInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    if (AuthService.to.isLoggedInValue) {
      options.queryParameters['cookie'] = '';
    }
    return super.onRequest(options);
  }
}
