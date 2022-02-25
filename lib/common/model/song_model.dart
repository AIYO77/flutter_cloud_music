import 'package:flutter_cloud_music/common/model/privilege_model.dart';
import 'package:get/get.dart';
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
  int? copyright;

  @JsonKey(name: 'originCoverType')
  int? originCoverType;

  @JsonKey(name: 'mv')
  int? mv;

  @JsonKey(name: 'videoInfo')
  VideoInfo? videoInfo;

  @JsonKey(name: 'privilege')
  PrivilegeModel? privilege;

  @JsonKey(name: 'actionType')
  String? actionType;

  @JsonKey(name: 'originSongSimpleData')
  OriginSongSimpleData? originSongSimpleData;

  String? reason;

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

  factory Song.fromMatedata(MusicMetadata metadata) {
    return Song.fromJson(metadata.extras!.cast<String, dynamic>());
  }

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        json['name'] as String,
        json['id'] as int,
        (json['ar'] as List<dynamic>)
            .map((e) => Ar.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        (json['alia'] as List<dynamic>).map((e) => e as String).toList(),
        json['fee'] as int,
        json['v'] as int,
        AlbumSimple.fromJson(Map<String, dynamic>.from(json['al'])),
        json['copyright'] as int?,
        json['originCoverType'] as int?,
        json['mv'] as int?,
        json['videoInfo'] == null
            ? null
            : VideoInfo.fromJson(Map<String, dynamic>.from(json['videoInfo'])),
        json['privilege'] == null
            ? null
            : PrivilegeModel.fromJson(
                Map<String, dynamic>.from(json['privilege'])),
        json['actionType'] as String?,
        json['originSongSimpleData'] == null
            ? null
            : OriginSongSimpleData.fromJson(
                Map<String, dynamic>.from(json['originSongSimpleData'])),
        json['st'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'id': id,
        'ar': ar.map((e) => e.toJson()).toList(),
        'alia': alia,
        'fee': fee,
        'v': v,
        'st': st,
        'al': al.toJson(),
        'copyright': copyright,
        'originCoverType': originCoverType,
        'mv': mv,
        'videoInfo': videoInfo?.toJson(),
        'privilege': privilege?.toJson(),
        'actionType': actionType,
        'originSongSimpleData': originSongSimpleData?.toJson(),
      };

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
        subtitle: arString(),
        iconUri: al.picUrl,
        extras: toJson());
    return _metadata!;
  }

  bool canPlay() {
    return true;
    // return st == 0 || st == 1;
  }

  String arString() {
    return ar.map((e) => e.name!).reduce((value, element) => '$value/$element');
  }

  List<int> arIds() {
    return ar.map((e) => e.id).toList();
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

  @JsonKey(name: 'picUrl')
  String? picUrl;

  @JsonKey(name: 'followed')
  bool? followed;

  @JsonKey(name: 'accountId')
  int? accountId;

  @JsonKey(name: 'fansCount')
  int? fansCount;

  Ar(
    this.id,
    this.name,
    this.tns,
    this.alias,
    this.picUrl,
    this.followed,
    this.accountId,
    this.fansCount,
  );

  factory Ar.fromJson(Map<String, dynamic> srcJson) => _$ArFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArToJson(this);

  String? getNameStr() {
    if (GetUtils.isNullOrBlank(alias) == true) return name;
    return '$name(${alias?.map((e) => e.toString()).join('/')})';
  }
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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'moreThanOne': moreThanOne,
        'video': video?.toJson(),
      };
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
      OriginSongSimpleData(
        (srcJson['artists'] as List<dynamic>)
            .map((e) => Ar.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'artists': artists.map((e) => e.toJson()).toList(),
      };
}

extension MusicBuilder on MusicMetadata {
  Song toMusic() {
    return Song.fromMatedata(this);
  }
}

extension MusicListExt on List<Song> {
  List<MusicMetadata> toMetadataList() {
    return map((e) => e.metadata).toList();
  }
}
