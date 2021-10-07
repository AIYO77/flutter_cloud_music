import 'package:flutter_cloud_music/common/model/privilege_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:music_player/music_player.dart';

part 'song_model.g.dart';

@JsonSerializable()
class Song extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'ar')
  List<Ar> ar;

  @JsonKey(name: 'alia')
  List<String> alia;

  @JsonKey(name: 'fee')
  int fee;

  @JsonKey(name: 'v')
  int v;

  @JsonKey(name: 'st')
  int st;

  @JsonKey(name: 'al')
  AlbumSimple al;

  @JsonKey(name: 'copyright')
  int copyright;

  @JsonKey(name: 'originCoverType')
  int originCoverType;

  @JsonKey(name: 'mv')
  int mv;

  @JsonKey(name: 'videoInfo')
  VideoInfo? videoInfo;

  @JsonKey(name: 'privilege')
  PrivilegeModel? privilege;

  @JsonKey(name: 'actionType')
  String? actionType;

  @JsonKey(name: 'originSongSimpleData')
  OriginSongSimpleData? originSongSimpleData;

  Song(
    this.name,
    this.id,
    this.ar,
    this.alia,
    this.fee,
    this.v,
    this.al,
    this.copyright,
    this.originCoverType,
    this.mv,
    this.videoInfo,
    this.privilege,
    this.actionType,
    this.originSongSimpleData,
    this.st,
  );

  factory Song.fromJson(Map<String, dynamic> srcJson) =>
      _$SongFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SongToJson(this);

  String getSongCellSubTitle() {
    final ars =
        ar.map((e) => e.name!).reduce((value, element) => '$value/$element');
    String str = '$ars - ${al.name}';
    if (originSongSimpleData != null) {
      final originArs = originSongSimpleData!.artists
          .map((e) => e.name)
          .reduce((value, element) => '$value/$element');
      str += ' ｜ 原唱：$originArs';
    }
    return str;
  }

  MusicMetadata? _metadata;

  MusicMetadata get metadata {
    _metadata ??= MusicMetadata(
      mediaId: id.toString(),
      title: name +
          (alia.isNotEmpty
              ? alia.reduce((value, element) => '$value $element')
              : ''),
      subtitle: getSongCellSubTitle(),
      iconUri: al.picUrl,
    );
    return _metadata!;
  }

  bool canPlay() {
    return st == 0;
  }
}

@JsonSerializable()
class Ar extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'tns')
  List<dynamic>? tns;

  @JsonKey(name: 'alias')
  List<dynamic>? alias;

  Ar(
    this.id,
    this.name,
    this.tns,
    this.alias,
  );

  factory Ar.fromJson(Map<String, dynamic> srcJson) => _$ArFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArToJson(this);
}

@JsonSerializable()
class AlbumSimple extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'picUrl')
  String? picUrl;

  @JsonKey(name: 'pic_str')
  String? picStr;

  AlbumSimple(this.id, this.name, this.picUrl, this.picStr);

  factory AlbumSimple.fromJson(Map<String, dynamic> srcJson) =>
      _$AlbumSimpleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlbumSimpleToJson(this);
}

@JsonSerializable()
class VideoInfo extends Object {
  @JsonKey(name: 'moreThanOne')
  bool moreThanOne;

  @JsonKey(name: 'video')
  Video? video;

  VideoInfo(
    this.moreThanOne,
    this.video,
  );

  factory VideoInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$VideoInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoInfoToJson(this);
}

@JsonSerializable()
class Video extends Object {
  @JsonKey(name: 'vid')
  String? vid;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'playTime')
  int playTime;

  @JsonKey(name: 'coverUrl')
  String? coverUrl;

  @JsonKey(name: 'publishTime')
  int publishTime;

  Video(
    this.vid,
    this.type,
    this.title,
    this.playTime,
    this.coverUrl,
    this.publishTime,
  );

  factory Video.fromJson(Map<String, dynamic> srcJson) =>
      _$VideoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}

@JsonSerializable()
class OriginSongSimpleData extends Object {
  @JsonKey(name: 'artists')
  List<Ar> artists;

  OriginSongSimpleData(this.artists);

  factory OriginSongSimpleData.fromJson(Map<String, dynamic> srcJson) =>
      _$OriginSongSimpleDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OriginSongSimpleDataToJson(this);
}
