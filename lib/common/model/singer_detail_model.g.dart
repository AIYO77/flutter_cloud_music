// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'singer_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingerDetailModel _$SingerDetailModelFromJson(Map<String, dynamic> json) =>
    SingerDetailModel(
      json['videoCount'] as int,
      Identify.fromJson(json['identify'] as Map<String, dynamic>),
      Artist.fromJson(json['artist'] as Map<String, dynamic>),
      json['user'] == null
          ? null
          : UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingerDetailModelToJson(SingerDetailModel instance) =>
    <String, dynamic>{
      'videoCount': instance.videoCount,
      'identify': instance.identify,
      'artist': instance.artist,
      'user': instance.user,
    };

Identify _$IdentifyFromJson(Map<String, dynamic> json) => Identify(
      json['imageUrl'] as String?,
      json['imageDesc'] as String?,
      json['actionUrl'] as String?,
    );

Map<String, dynamic> _$IdentifyToJson(Identify instance) => <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'imageDesc': instance.imageDesc,
      'actionUrl': instance.actionUrl,
    };

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist(
      json['id'] as int,
      json['cover'] as String,
      json['name'] as String,
      json['briefDesc'] as String,
      json['albumSize'] as int,
      json['musicSize'] as int,
      json['mvSize'] as int,
      json['followed'] as bool?,
    );

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'id': instance.id,
      'cover': instance.cover,
      'name': instance.name,
      'briefDesc': instance.briefDesc,
      'albumSize': instance.albumSize,
      'musicSize': instance.musicSize,
      'mvSize': instance.mvSize,
      'followed': instance.followed,
    };
