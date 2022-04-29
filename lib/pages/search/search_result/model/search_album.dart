import 'package:flutter_cloud_music/common/model/album_detail.dart';
import 'package:flutter_cloud_music/pages/search/search_result/model/base_model.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/28 1:43 下午
/// Des:

class SearchAlbum extends BaseSearchModel {
  final List<Album> albums;

  SearchAlbum.fromJson(Map<String, dynamic> json)
      : albums =
            (json['albums'] as List).map((e) => Album.fromJson(e)).toList(),
        super.fromJson(json);
}
