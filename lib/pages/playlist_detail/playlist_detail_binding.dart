import 'package:get/get.dart';
import 'playlist_detail_controller.dart';

class PlaylistDetailBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<PlaylistDetailController>(() => PlaylistDetailController());
    }
}
