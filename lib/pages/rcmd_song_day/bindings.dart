import 'package:get/get.dart';

import 'controller.dart';

class RcmdSongDayBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RcmdSongDayController>(() => RcmdSongDayController());
  }
}
