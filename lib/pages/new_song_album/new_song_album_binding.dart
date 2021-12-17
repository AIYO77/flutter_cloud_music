import 'package:get/get.dart';

import 'new_song_album_controller.dart';

class NewSongAlbumBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NewSongAlbumController>(NewSongAlbumController());
    // Get.lazyPut<NewSongAlbumController>(() => NewSongAlbumController());
  }
}
