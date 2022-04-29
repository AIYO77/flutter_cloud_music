import 'package:get/get.dart';

import 'logic.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchLogic());
  }
}
