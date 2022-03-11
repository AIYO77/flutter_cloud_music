import 'package:get/get.dart';

import 'logic.dart';

class SingleSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingleSearchLogic());
  }
}
