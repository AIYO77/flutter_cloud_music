/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/24 4:14 下午
/// Des:
import 'package:flutter_cloud_music/pages/playlist_collection/selection/controller.dart';
import 'package:get/get.dart';

class PlaylistTagBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TagAllController>(() => TagAllController());
  }
}
