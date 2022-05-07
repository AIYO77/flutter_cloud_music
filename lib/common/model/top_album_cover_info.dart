import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'top_album_cover_info.g.dart';

@JsonSerializable()
class TopAlbumCoverInfo extends Object {
  @JsonKey(name: 'alias')
  List<String> alias;

  @JsonKey(name: 'artists')
  List<Ar> artists;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'publishTime')
  int publishTime;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'size')
  int size;

  TopAlbumCoverInfo(
    this.alias,
    this.artists,
    this.description,
    this.publishTime,
    this.picUrl,
    this.name,
    this.id,
    this.size,
  );

  factory TopAlbumCoverInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$TopAlbumCoverInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TopAlbumCoverInfoToJson(this);

  String getAlbumName() {
    if (alias.isEmpty) return name;
    return '$name${alias.join('/')}';
  }

  String getArName() {
    return artists.map((e) => e.getNameStr()).join('/');
  }
}
