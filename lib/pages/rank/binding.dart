import 'package:get/get.dart';

import 'logic.dart';

class RankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RankLogic());
  }
}
