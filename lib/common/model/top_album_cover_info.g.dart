// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_album_cover_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopAlbumCoverInfo _$TopAlbumCoverInfoFromJson(Map<String, dynamic> json) =>
    TopAlbumCoverInfo(
      (json['alias'] as List<dynamic>).map((e) => e as String).toList(),
      (json['artists'] as List<dynamic>)
          .map((e) => Ar.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['description'] as String,
      json['publishTime'] as int,
      json['picUrl'] as String,
      json['company'] as String,
      json['name'] as String,
      json['id'] as int,
      json['size'] as int,
    );

Map<String, dynamic> _$TopAlbumCoverInfoToJson(TopAlbumCoverInfo instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'artists': instance.artists,
      'description': instance.description,
      'publishTime': instance.publishTime,
      'picUrl': instance.picUrl,
      'company': instance.company,
      'name': instance.name,
      'id': instance.id,
      'size': instance.size,
    };
