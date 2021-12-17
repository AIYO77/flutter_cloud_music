import 'package:flutter/services.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with SingleGetTickerProviderMixin {
  final bool isFirst = box.read<bool>('isFirst') ?? true;

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
  }

  @override
  Future<void> onReady() async {
    await Future.delayed(Duration(milliseconds: isFirst ? 6000 : 2000));
    toHome();
  }

  @override
  void onClose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  }

  void toHome() {
    box.write('isFirst', false);
    Get.offAllNamed(Routes.HOME);
  }
}
