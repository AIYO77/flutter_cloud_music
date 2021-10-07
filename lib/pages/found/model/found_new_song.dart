import 'package:flutter_cloud_music/common/model/privilege_model.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'found_new_song.g.dart';

@JsonSerializable()
class FoundNewSong extends Object {
  @JsonKey(name: 'songData')
  SongData songData;

  @JsonKey(name: 'songPrivilege')
  PrivilegeModel songPrivilege;

  FoundNewSong(
    this.songData,
    this.songPrivilege,
  );

  factory FoundNewSong.fromJson(Map<String, dynamic> srcJson) =>
      _$FoundNewSongFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FoundNewSongToJson(this);

  Song buildSong(String? type) {
    return Song(
        songData.name,
        songData.id,
        songData.artists,
        songData.alias,
        songData.fee,
        100,
        songData.album,
        songData.copyright,
        songData.originCoverType,
        songData.mvid,
        null,
        songPrivilege,
        type,
        null,
        1);
  }
}

@JsonSerializable()
class SongData extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'fee')
  int fee;

  @JsonKey(name: 'copyright')
  int copyright;

  @JsonKey(name: 'originCoverType')
  int originCoverType;

  @JsonKey(name: 'mvid')
  int mvid;

  @JsonKey(name: 'alias')
  List<String> alias;

  @JsonKey(name: 'artists')
  List<Ar> artists;

  @JsonKey(name: 'album')
  AlbumSimple album;

  SongData(
    this.name,
    this.id,
    this.fee,
    this.copyright,
    this.originCoverType,
    this.mvid,
    this.alias,
    this.artists,
    this.album,
  );

  factory SongData.fromJson(Map<String, dynamic> srcJson) =>
      _$SongDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SongDataToJson(this);
}
