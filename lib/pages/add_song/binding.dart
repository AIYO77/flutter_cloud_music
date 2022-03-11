import 'package:get/get.dart';

import 'logic.dart';

class AddSongBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddSongLogic());
  }
}
