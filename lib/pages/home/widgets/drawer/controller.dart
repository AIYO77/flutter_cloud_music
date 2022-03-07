import 'package:flutter_cloud_music/api/login_api.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/2/28 4:05 下午
/// Des:

class HomeDrawerController extends GetxController {
  Future<void> logout() async {
    EasyLoading.show(status: '加载中...');
    LoginApi.logout().then((value) {
      if (value) {
        Get.back();
      }
      EasyLoading.dismiss();
    });
  }
}
