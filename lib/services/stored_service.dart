import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:get/get.dart';

import '../common/values/constants.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/14 2:39 下午
/// Des:

class StoredService extends GetxService {
  static StoredService get to => Get.find();

  final historySearch = Rx<List<String>?>(null);

  @override
  void onInit() {
    super.onInit();
    historySearch.value =
        box.read<List<dynamic>>(CACHE_HISTORY_SEARCH)?.cast<String>();
  }

  void updateSearch(String keywords) {
    final oldList =
        box.read<List<dynamic>>(CACHE_HISTORY_SEARCH)?.cast<String>();
    if (oldList == null) {
      final list = List<String>.empty(growable: true);
      list.add(keywords);
      box.write(CACHE_HISTORY_SEARCH, list);
      historySearch.value = list;
    } else {
      if (oldList.contains(keywords)) {
        oldList.remove(keywords);
      }
      oldList.insert(0, keywords);
      final newList = List<String>.from(oldList);
      box.write(CACHE_HISTORY_SEARCH, newList);
      historySearch.value = newList;
    }
  }

  Future<void> clearSearchHistory() async {
    historySearch.value = null;
    box.remove(CACHE_HISTORY_SEARCH);
  }
}
