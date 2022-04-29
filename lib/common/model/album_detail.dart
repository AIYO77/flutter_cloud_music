import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'album_detail.g.dart';

@JsonSerializable()
class AlbumDetail extends Object {
  @JsonKey(name: 'resourceState')
  bool resourceState;

  @JsonKey(name: 'songs')
  List<Song> songs;

  @JsonKey(name: 'album')
  Album album;

  AlbumDetail(
    this.resourceState,
    this.songs,
    this.album,
  );

  factory AlbumDetail.fromJson(Map<String, dynamic> srcJson) =>
      _$AlbumDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlbumDetailToJson(this);
}

@JsonSerializable()
class Album extends Object {
  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'publishTime')
  int publishTime;

  @JsonKey(name: 'briefDesc')
  String briefDesc;

  @JsonKey(name: 'artist')
  Ar artist;

  @JsonKey(name: 'artists')
  List<Ar>? artists;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'size')
  int size;

  Album(
    this.picUrl,
    this.publishTime,
    this.briefDesc,
    this.artist,
    this.artists,
    this.description,
    this.name,
    this.id,
    this.size,
  );

  factory Album.fromJson(Map<String, dynamic> srcJson) =>
      _$AlbumFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  String timeStr() {
    final date = DateTime.fromMillisecondsSinceEpoch(publishTime);
    return '${date.year}-${date.month}-${date.day}';
  }
}
