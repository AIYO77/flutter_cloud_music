import 'package:flutter_cloud_music/pages/search/search_result/model/base_model.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/28 1:49 下午
/// Des:

class SearchSimQuery extends BaseSearchModel {
  final List<KeywordValue> sim_querys;

  SearchSimQuery.fromJson(Map<String, dynamic> json)
      : sim_querys = (json['sim_querys'] as List)
            .map((e) => KeywordValue.fromJson(e))
            .toList(),
        super.fromJson(json);
}

class KeywordValue {
  final String keyword;

  const KeywordValue(this.keyword);

  KeywordValue.fromJson(Map<String, dynamic> json)
      : keyword = json['keyword'].toString();
}
