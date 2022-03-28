import 'package:get/get.dart';

import 'logic.dart';

class VideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VideoLogic());
  }
}
