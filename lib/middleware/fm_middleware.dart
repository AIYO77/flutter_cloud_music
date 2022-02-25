import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/player/player_service.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/2/24 8:15 下午
/// Des:

class FMMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!AuthService.to.isLoggedInValue) {
      return const RouteSettings(name: Routes.LOGIN);
    }
    if (!PlayerService.to.isFmPlaying.value) {
      return RouteSettings(name: Routes.PAGE_LOADING_THEN(Routes.PRIVATE_FM));
    }
    return super.redirect(route);
  }
}
