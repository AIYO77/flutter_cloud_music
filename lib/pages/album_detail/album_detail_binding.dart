import 'package:flutter_cloud_music/pages/album_detail/album_detail_controller.dart';
import 'package:get/get.dart';

class AlbumDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlbumDetailController>(() => AlbumDetailController());
  }
}
