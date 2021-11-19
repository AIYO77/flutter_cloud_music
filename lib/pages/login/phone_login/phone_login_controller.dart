import 'dart:convert';

import 'package:flutter_cloud_music/api/login_api.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/pages/login/phone_login/model/phone_exist.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:get/get.dart';

class PhoneLoginController extends GetxController {
  // 国家码 默认中国
  final countrycode = '86'.obs;
  //手机号码
  final phone = ''.obs;

  //下一步按钮是否可用
  final nextBtnEnable = false.obs;

  void next() {
    nextBtnEnable.value = false;
    LoginApi.checkPhoneExistence(phone.value, countrycode.value).then((value) {
      logger.d('是否注册过 = ${value?.exist == 1}');

      sendVerCode(value);
    });
  }

  //发送验证码
  void sendVerCode(PhoneExist? phoneExist) {
    LoginApi.sendCode(phone.value, countrycode.value).then((value) {
      logger.d('发送验证码 ${value ? '成功' : '失败'}');
      nextBtnEnable.value = true;
      Get.offAndToNamed(Routes.VER_CODE, parameters: {
        'exist': phoneExist?.exist.toString() ?? '-1',
        'hasPassword': phoneExist?.hasPassword.toString() ?? false.toString(),
        'phone': phone.value,
        'code': countrycode.value
      });
    });
  }
}
