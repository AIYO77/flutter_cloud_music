import 'package:get/get.dart';
import 'podcast_controller.dart';

class PodcastBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<PodcastController>(() => PodcastController());
    }
}
