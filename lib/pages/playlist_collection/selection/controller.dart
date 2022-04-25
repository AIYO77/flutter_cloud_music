import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/event/index.dart';
import 'package:flutter_cloud_music/common/utils/collections.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/play_list_tag_model.dart';
import 'package:get/get.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/24 4:14 下午
/// Des:

class TagAllController extends GetxController {
  final items = Rx<List<TagTypeModel>?>(null);

  //使用中的tag
  late List<PlayListTagModel> _activityList;

  //是否是编辑状态
  final isEditState = false.obs;

  @override
  void onInit() {
    super.onInit();
    _activityList = (Get.arguments as List).cast<PlayListTagModel>();
    for (final element in _activityList) {
      element.activity = true;
    }
  }

  @override
  void onClose() {
    if (items.value != null) {
      final myPlTag = items.value!.firstWhere((element) => element.type == -1);

      if (!Collections.compareIsSame(myPlTag.tags, _activityList)) {
        logger.d('有调整');
        eventBus.fire(myPlTag);
      } else {
        logger.d('没有调整');
      }
    }
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    _requestAllTags();
  }

  Future _requestAllTags() async {
    final List<TagTypeModel> data = [];
    data.add(
        TagTypeModel(type: -1, name: '我的歌单广场', tags: List.of(_activityList)));
    final result = await MusicApi.getPlCatlist();
    if (result != null) {
      for (final cat in result.categories.keys) {
        data.add(TagTypeModel(
            type: int.parse(cat),
            name: result.categories[cat]!,
            tags: result.sub
                .where((element) => element.category == int.parse(cat))
                .map((e) => e
                  ..activity = _activityList.firstWhereOrNull(
                          (element) => element.name == e.name) !=
                      null)
                .toList()));
      }
      items.value = data;
    }
  }

  ///减
  void subTag(PlayListTagModel tag) {
    final oldList = items.value!;
    final model = oldList.firstWhere((element) => element.type == -1);
    model.tags.removeWhere((element) => element.name == tag.name);
    oldList
        .firstWhere((element) => element.type == tag.category)
        .tags
        .firstWhereOrNull((element) => element.name == tag.name)
        ?.activity = false;
    items.value = List.of(oldList);
  }

  ///加
  void addTag(PlayListTagModel tag) {
    final oldList = items.value!;
    final model = oldList.firstWhere((element) => element.type == -1);
    model.tags.add(tag);
    tag.activity = true;
    items.value = List.of(oldList);
  }
}

class TagTypeModel {
  final int type;
  final String name;
  final List<PlayListTagModel> tags;

  const TagTypeModel(
      {required this.type, required this.name, required this.tags});
}
