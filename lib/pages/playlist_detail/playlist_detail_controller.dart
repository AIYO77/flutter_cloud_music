import 'package:get/get.dart';

class PlaylistDetailController extends GetxController {
  String playlistId = ''; //歌单ID
  String autoplay = '0'; //自动播放 0否

  @override
  void onInit() {
    playlistId = Get.parameters['id'] ?? "";
    autoplay = Get.parameters['autoplay'] ?? "";
    Get.log('playlistId = $playlistId autoplay = $autoplay');
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
