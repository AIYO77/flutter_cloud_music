import 'package:get/get.dart';
import 'pwd_login_controller.dart';

class PwdLoginBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<PwdLoginController>(() => PwdLoginController());
    }
}
