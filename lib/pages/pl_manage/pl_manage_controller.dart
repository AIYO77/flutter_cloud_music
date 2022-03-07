import 'package:flutter_cloud_music/common/model/mine_playlist.dart';
import 'package:get/get.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/7 5:15 下午
/// Des:

class PlManageController extends GetxController {
  late List<MinePlaylist> playlist;

  //选中的歌单
  final selectedPl = Rx<List<MinePlaylist>?>(null);

  @override
  void onInit() {
    super.onInit();
    playlist = Get.arguments as List<MinePlaylist>;
  }

  void finish() {}

  @override
  void onReady() {}

  @override
  void onClose() {}
}
