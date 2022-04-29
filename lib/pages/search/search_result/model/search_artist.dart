import 'package:flutter_cloud_music/common/model/artists_model.dart';
import 'package:flutter_cloud_music/pages/search/search_result/model/base_model.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/28 11:59 上午
/// Des:

class SearchArtist extends BaseSearchModel {
  final List<Artists> artists;

  SearchArtist.fromJson(Map<String, dynamic> json)
      : artists =
            (json['artists'] as List).map((e) => Artists.fromJson(e)).toList(),
        super.fromJson(json);
}
