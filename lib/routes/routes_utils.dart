import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:get/get.dart';

class RouteUtils {
  static void routeFromActionStr(String? action) {
    if (action == null) return;
    if (action.startsWith(Routes.ROUTES_HOST)) {
      //应用内跳转
      Get.toNamed('/$action');
      return;
    }
    Get.snackbar("", action);
  }
}
