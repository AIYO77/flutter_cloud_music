/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/14 7:36 下午
/// Des:
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_new_song.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_songs.g.dart';

@JsonSerializable()
class SearchSongs extends Object {
  @JsonKey(name: 'songs')
  List<SongData> songs;

  @JsonKey(name: 'hasMore')
  bool hasMore;

  @JsonKey(name: 'songCount')
  int songCount;

  SearchSongs(
    this.songs,
    this.hasMore,
    this.songCount,
  );

  factory SearchSongs.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchSongsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchSongsToJson(this);
}
