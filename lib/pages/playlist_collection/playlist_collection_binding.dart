import 'package:get/get.dart';
import 'playlist_collection_controller.dart';

class PlaylistCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaylistCollectionController>(
        () => PlaylistCollectionController());
  }
}
