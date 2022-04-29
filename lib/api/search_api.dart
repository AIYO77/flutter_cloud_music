import 'package:flutter_cloud_music/common/model/hot_search_model.dart';
import 'package:flutter_cloud_music/common/model/search_suggest.dart';
import 'package:flutter_cloud_music/common/net/init_dio.dart';
import 'package:flutter_cloud_music/services/stored_service.dart';
import 'package:get/get.dart';

import '../common/values/constants.dart';
import '../pages/found/model/default_search_model.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/11 7:44 下午
/// Des:

class SearchApi {
  ///搜索建议
  static Future<List<SearchSuggest>?> suggest(String word) async {
    final response = await httpManager
        .get('/search/suggest', {'keywords': word, 'type': 'mobile'});
    if (response.result) {
      final result = response.data['result'];
      if (GetUtils.isNullOrBlank(result) == true) {
        return List.empty();
      } else {
        final list = result['allMatch'] as List;
        return list.map((e) => SearchSuggest.fromJson(e)).toList();
      }
    }
    return null;
  }

  ///默认搜索
  static Future<DefaultSearchModel?> getDefaultSearch() async {
    DefaultSearchModel? data;
    final response = await httpManager.get('/search/default',
        {'timestamp': DateTime.now().millisecondsSinceEpoch});
    if (response.result) {
      data = DefaultSearchModel.fromJson(response.data['data']);
    }
    return data;
  }

  ///搜索
  ///keywords : 关键词
  ///offset : 偏移数量，用于分页
  ///type: 搜索类型
  static Future<dynamic> search(String keywords,
      {int offset = 0, int type = SEARCH_SONGS}) async {
    StoredService.to.updateSearch(keywords);
    final response = await httpManager.get('/search', {
      'keywords': keywords,
      'limit': 30,
      'offset': offset,
      'type': type,
    });
    if (response.isSuccess()) {
      return response.data['result'];
    }
    return null;
  }

  ///热门搜索
  static Future<List<HotSearch>> getHotSearch() async {
    final response = await httpManager.get('/search/hot/detail', null);
    if (response.isSuccess()) {
      return HotSearchModel.fromJson(response.data).data;
    }
    return List.empty();
  }
}
