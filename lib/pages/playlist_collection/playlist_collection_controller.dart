import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/play_list_tag_model.dart';
import 'package:get/get.dart';

class PlaylistCollectionController extends GetxController {
  final String PLAYLIST_TAGS = "playlist_tags";

  int selectedIndex = 0;
  String categoryName = '';

  final localTags = [
    PlayListTagModel(true, true, '推荐', -1, 1, null),
    PlayListTagModel(true, true, '官方', -2, 1, null),
    PlayListTagModel(true, true, '精品', -3, 1, null),
  ];

  final tags = Rx<List<PlayListTagModel>?>(null);

  @override
  void onInit() {
    if (Get.parameters.containsKey('tabPage')) {
      selectedIndex = int.parse(Get.parameters['tabPage'].toString());
    }
    if (Get.parameters.containsKey('categoryName')) {
      categoryName = Get.parameters['categoryName'].toString();
    }
    super.onInit();
  }

  @override
  void onReady() {
    tags.value = box.read<List<PlayListTagModel>?>(PLAYLIST_TAGS);
    if (GetUtils.isNullOrBlank(tags.value) == true) {
      //为空说明没有缓存过 请求接口
      getHotTags();
    } else {
      Get.log('存在 ${tags.value?.map((e) => e.name).toString()}');
    }
  }

  @override
  void onClose() {}

  Future<void> getHotTags() async {
    final data = await MusicApi.getHotTags();
    if (data != null) {
      data.sort((a, b) => b.usedCount!.compareTo(a.usedCount!));
      final newTags = data.sublist(0, 5);
      newTags.insertAll(0, localTags);
      resetTags(newTags);
    } else {
      tags.value = localTags;
    }
  }

  void resetTags(List<PlayListTagModel> data) {
    Get.log(data.map((e) => e.name).toString());
    box.write(PLAYLIST_TAGS, data);
    tags.value = data;
  }
}
