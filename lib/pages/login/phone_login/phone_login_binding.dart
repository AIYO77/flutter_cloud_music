import 'package:get/get.dart';
import 'phone_login_controller.dart';

class PhoneLoginBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<PhoneLoginController>(() => PhoneLoginController());
    }
}
