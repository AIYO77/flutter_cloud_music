import 'package:flutter_cloud_music/common/player/widgets/lyric/lyric_controller.dart';
import 'package:get/get.dart';
import 'playing_controller.dart';

class PlayingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayingController>(() => PlayingController());
  }
}
