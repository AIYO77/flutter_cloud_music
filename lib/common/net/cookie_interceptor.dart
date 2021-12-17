import 'package:dio/dio.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';

class CookieInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (AuthService.to.isLoggedInValue && AuthService.to.cookie != null) {
      options.queryParameters['cookie'] = AuthService.to.cookie;
    }
    //Vercel部署的 需要额外加一个 realIP 参数 国内的IP地址就可以 这里是百度的
    options.queryParameters['realIP'] = '202.108.22.5';
    super.onRequest(options, handler);
  }
}
