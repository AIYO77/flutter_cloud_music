import 'package:flutter_cloud_music/common/event/index.dart';
import 'package:flutter_cloud_music/common/event/login_event.dart';
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

  int? userId;

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
    refreshCookie(loginResponse.cookie);
    userId = loginResponse.profile?.userId ?? loginResponse.account.id;
    loginData.value = loginResponse;
    box.write(CACHE_LOGIN_DATA, loginResponse.toJson());
    isLoggedIn.value = true;
    eventBus.fire(LoginEvent(true));
  }

  /*退出登陆成功后 清除本地缓存*/
  Future<void> logout() async {
    loginData.value = null;
    cookie = null;
    await box.remove(CACHE_LOGIN_DATA);
    isLoggedIn.value = false;
    eventBus.fire(LoginEvent(false));
  }

  void refreshCookie(String s) {
    cookie = Uri.encodeComponent(s);
    logger.i(cookie);
  }
}
