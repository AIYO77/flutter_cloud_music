import 'package:get/get.dart';
import 'cloud_village_controller.dart';

class CloudVillageBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<CloudVillageController>(() => CloudVillageController());
    }
}
