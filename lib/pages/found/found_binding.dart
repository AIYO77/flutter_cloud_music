import 'package:get/get.dart';
import 'found_controller.dart';

class FoundBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoundController>(() => FoundController());
  }
}
