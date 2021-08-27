import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final isLoggedIn = false.obs;
  bool get isLoggedInValue => isLoggedIn.value;

  void login() {
    isLoggedIn.value = true;
  }

  void logout() {
    isLoggedIn.value = false;
  }
}
