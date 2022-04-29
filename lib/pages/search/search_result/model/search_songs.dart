import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/pages/search/search_result/model/base_model.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/28 11:23 上午
/// Des:

class SearchSongs extends BaseSearchModel {
  final List<Song> songs;

  SearchSongs.fromJson(Map<String, dynamic> json)
      : songs = (json['songs'] as List).map((e) => Song.fromJson(e)).toList(),
        super.fromJson(json);
}
