import 'package:flutter_cloud_music/api/login_api.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EmailLoginController extends GetxController {
  String _email = '';
  String _pwd = '';
  final btnEnable = false.obs;

  void setEmail(String e) {
    _email = e;
    btnEnable.value = _email.isNotEmpty && _pwd.isNotEmpty;
  }

  void setPwd(String p) {
    _pwd = p;
    btnEnable.value = _email.isNotEmpty && _pwd.isNotEmpty;
  }

  void emailLogin() {
    EasyLoading.show(status: '加载中...');
    LoginApi.emailLogin(_email, _pwd).then((value) {
      EasyLoading.dismiss();
      if (value) {
        //登陆成功
        Get.offNamed(Routes.LOGIN);
        Get.offNamed(Routes.EMAIL_LOGIN);
      }
    });
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
