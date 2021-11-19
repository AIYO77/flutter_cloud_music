import 'package:flutter_cloud_music/common/model/login_response.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final isLoggedIn = false.obs;

  bool get isLoggedInValue => isLoggedIn.value;

  String? cookie;

  final loginData = Rx<LoginResponse?>(null);

  @override
  void onInit() {
    super.onInit();
    final loginCache = box.read<Map<String, dynamic>>(CACHE_LOGIN_DATA);
    if (loginCache != null) {
      logger.d('有登陆信息');
      login(LoginResponse.fromJson(loginCache));
    }
  }

  //登陆处理逻辑
  void login(LoginResponse loginResponse) {
    isLoggedIn.value = true;
    refreshCookie(loginResponse.cookie);
    loginData.value = loginResponse;
    box.write(CACHE_LOGIN_DATA, loginResponse.toJson());
  }

  void logout() {
    isLoggedIn.value = false;
  }

  void refreshCookie(String s) {
    cookie = Uri.encodeComponent(s);
  }
}
