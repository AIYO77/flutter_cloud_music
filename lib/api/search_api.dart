import 'package:flutter_cloud_music/common/model/search_suggest.dart';
import 'package:flutter_cloud_music/common/net/init_dio.dart';

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
      final list = response.data['result']['allMatch'] as List;
      return list.map((e) => SearchSuggest.fromJson(e)).toList();
    }
    return null;
  }
}
