import 'package:get/get.dart';
import 'web_controller.dart';

class WebBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<WebController>(() => WebController());
    }
}
