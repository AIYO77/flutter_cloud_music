import 'package:get/get.dart';
import 'verification_code_controller.dart';

class VerificationCodeBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<VerificationCodeController>(() => VerificationCodeController());
    }
}
