import 'package:get/get.dart';

import '../../../api/video_api.dart';
import '../../found/model/shuffle_log_model.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/16 11:16 上午
/// Des:

class AddVideoController extends GetxController {
  final String tag;

  AddVideoController(this.tag);

  final videos = Rx<List<MLogResource>?>(null);

  @override
  void onReady() {
    super.onReady();
    _request();
  }

  Future<void> _request() async {
    List<MLogResource>? result;

    if (tag == 'like') {
      result = await VideoApi.getMyLikeVideos();
    } else {
      result = await VideoApi.getRecentVideos();
    }

    videos.value = result;
  }
}
