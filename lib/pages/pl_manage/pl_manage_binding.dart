import 'package:get/get.dart';

import 'pl_manage_controller.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/7 5:16 下午
/// Des:
class PlManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PlManageController());
  }
}
