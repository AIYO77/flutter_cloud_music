// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      json['name'] as String,
      json['id'] as int,
      (json['ar'] as List<dynamic>)
          .map((e) => Ar.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['alia'] as List<dynamic>).map((e) => e as String).toList(),
      json['fee'] as int,
      json['v'] as int,
      AlbumSimple.fromJson(json['al'] as Map<String, dynamic>),
      json['copyright'] as int,
      json['originCoverType'] as int,
      json['mv'] as int,
      json['videoInfo'] == null
          ? null
          : VideoInfo.fromJson(json['videoInfo'] as Map<String, dynamic>),
      json['privilege'] == null
          ? null
          : PrivilegeModel.fromJson(json['privilege'] as Map<String, dynamic>),
      json['actionType'] as String?,
      json['originSongSimpleData'] == null
          ? null
          : OriginSongSimpleData.fromJson(
              json['originSongSimpleData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'ar': instance.ar,
      'alia': instance.alia,
      'fee': instance.fee,
      'v': instance.v,
      'al': instance.al,
      'copyright': instance.copyright,
      'originCoverType': instance.originCoverType,
      'mv': instance.mv,
      'videoInfo': instance.videoInfo,
      'privilege': instance.privilege,
      'actionType': instance.actionType,
      'originSongSimpleData': instance.originSongSimpleData,
    };

Ar _$ArFromJson(Map<String, dynamic> json) => Ar(
      json['id'] as int,
      json['name'] as String?,
      json['tns'] as List<dynamic>?,
      json['alias'] as List<dynamic>?,
    );

Map<String, dynamic> _$ArToJson(Ar instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tns': instance.tns,
      'alias': instance.alias,
    };

AlbumSimple _$AlbumSimpleFromJson(Map<String, dynamic> json) => AlbumSimple(
      json['id'] as int,
      json['name'] as String?,
      json['picUrl'] as String?,
      json['pic_str'] as String?,
    );

Map<String, dynamic> _$AlbumSimpleToJson(AlbumSimple instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'pic_str': instance.picStr,
    };

VideoInfo _$VideoInfoFromJson(Map<String, dynamic> json) => VideoInfo(
      json['moreThanOne'] as bool,
      json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoInfoToJson(VideoInfo instance) => <String, dynamic>{
      'moreThanOne': instance.moreThanOne,
      'video': instance.video,
    };

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      json['vid'] as String?,
      json['type'] as int,
      json['title'] as String?,
      json['playTime'] as int,
      json['coverUrl'] as String?,
      json['publishTime'] as int,
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'vid': instance.vid,
      'type': instance.type,
      'title': instance.title,
      'playTime': instance.playTime,
      'coverUrl': instance.coverUrl,
      'publishTime': instance.publishTime,
    };

OriginSongSimpleData _$OriginSongSimpleDataFromJson(
        Map<String, dynamic> json) =>
    OriginSongSimpleData(
      (json['artists'] as List<dynamic>)
          .map((e) => Ar.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OriginSongSimpleDataToJson(
        OriginSongSimpleData instance) =>
    <String, dynamic>{
      'artists': instance.artists,
    };
