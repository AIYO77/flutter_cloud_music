import 'package:get/get.dart';
import 'email_login_controller.dart';

class EmailLoginBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<EmailLoginController>(() => EmailLoginController());
    }
}
