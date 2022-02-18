// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'singer_albums_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingerAlbumsModel _$SingerAlbumsModelFromJson(Map<String, dynamic> json) =>
    SingerAlbumsModel(
      (json['hotAlbums'] as List<dynamic>)
          .map((e) => HotAlbums.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['more'] as bool,
    );

Map<String, dynamic> _$SingerAlbumsModelToJson(SingerAlbumsModel instance) =>
    <String, dynamic>{
      'hotAlbums': instance.hotAlbums,
      'more': instance.more,
    };

HotAlbums _$HotAlbumsFromJson(Map<String, dynamic> json) => HotAlbums(
      json['publishTime'] as int,
      json['picUrl'] as String,
      json['name'] as String,
      json['id'] as int,
      json['size'] as int,
    );

Map<String, dynamic> _$HotAlbumsToJson(HotAlbums instance) => <String, dynamic>{
      'publishTime': instance.publishTime,
      'picUrl': instance.picUrl,
      'name': instance.name,
      'id': instance.id,
      'size': instance.size,
    };
