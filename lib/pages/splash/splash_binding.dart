import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    }
}
