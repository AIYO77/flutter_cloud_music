import 'package:get/get.dart';

import 'logic.dart';

class AddVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddVideoLogic());
  }
}
