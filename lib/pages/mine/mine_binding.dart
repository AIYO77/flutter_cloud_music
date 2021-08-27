import 'package:get/get.dart';
import 'mine_controller.dart';

class MineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MineController>(() => MineController());
  }
}
