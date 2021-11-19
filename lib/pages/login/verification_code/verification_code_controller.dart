import 'dart:async';

import 'package:flutter_cloud_music/api/login_api.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class VerificationCodeController extends GetxController {
  late String phone;
  late String countrycode;
  late bool exist;
  late bool hasPassword;

  Timer? _timer;
  //短信重新获取倒计时
  final countdownTime = 60.obs;

  @override
  void onInit() {
    exist = Get.parameters['exist'].toString() == '1';
    hasPassword =
        Get.parameters['hasPassword'].toString().toLowerCase() == 'true';
    phone = Get.parameters['phone'].toString();
    countrycode = Get.parameters['code'].toString();
    logger.d(
        'exist = $exist hasPassword = $hasPassword phone = $phone countrycode = $countrycode');
    super.onInit();
  }

  //开始倒计时
  void startCountdownTimer() {
    if (_timer?.isActive == true) {
      return;
    }
    countdownTime.value = 60;

    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (countdownTime.value < 1) {
        _timer?.cancel();
      } else {
        countdownTime.value = countdownTime.value - 1;
      }
    });
  }

  /*发送验证码 */
  void sendVerCode() {
    EasyLoading.show(status: '加载中');
    LoginApi.sendCode(phone, countrycode).then((value) {
      if (value) {
        EasyLoading.showSuccess('发送成功');
        startCountdownTimer();
        return;
      }
      EasyLoading.showError('发送失败');
    });
  }

  void verCode(String captcha) {
    EasyLoading.show(status: '加载中');
    if (exist) {
      //账号存在 验证码登陆
      LoginApi.phoneLogin(phone, countrycode, captcha: captcha).then((value) {
        EasyLoading.dismiss();
        if (value) {
          //登陆成功 关闭所有登陆相关的页面
          Get.offAllNamed(Routes.LOGIN);
        }
      });
    } else {
      //账号不存在 检查验证码的正确性 如果正确 调整
      LoginApi.verCode(phone, countrycode, captcha).then((value) {
        if (value) {
          //正确

        } else {
          EasyLoading.showError('验证码错误');
        }
      });
    }
  }

  String getPhoneSubStr() {
    if (GetUtils.isPhoneNumber(phone)) {
      return phone.replaceRange(3, 7, '****');
    }
    return phone;
  }

  @override
  void onReady() {
    startCountdownTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
  }
}
