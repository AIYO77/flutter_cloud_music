import 'package:get/get.dart';
import 'not_found_controller.dart';

class NotFoundBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotFoundController>(() => NotFoundController());
  }
}
