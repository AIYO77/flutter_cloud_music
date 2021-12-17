import 'package:flutter_cloud_music/api/login_api.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class PwdLoginController extends GetxController {
  late String phone;
  late String countrycode;
  final pwd = Rx<String?>(null);

  //密码登陆
  void pwdLogin() {
    EasyLoading.show(status: '加载中...');
    LoginApi.phoneLogin(phone, countrycode, password: pwd.value).then((value) {
      EasyLoading.dismiss();
      if (value) {
        Get.offAllNamed(Routes.VER_CODE);
        Get.offNamed(Routes.PWD_LOGIN);
      }
    });
  }

  @override
  void onReady() {
    phone = Get.parameters['phone'].toString();
    countrycode = Get.parameters['countrycode'].toString();
    logger.d('$phone  $countrycode');
  }

  @override
  void onClose() {}
}
