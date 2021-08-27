import 'package:get/get.dart';

class LoginController extends GetxController {
  final count = 0.obs;

  @override
  void onReady() {}

  @override
  void onClose() {}

  int increment() => count.value++;
}
