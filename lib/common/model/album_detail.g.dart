// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumDetail _$AlbumDetailFromJson(Map<String, dynamic> json) => AlbumDetail(
      json['resourceState'] as bool,
      (json['songs'] as List<dynamic>)
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      Album.fromJson(json['album'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AlbumDetailToJson(AlbumDetail instance) =>
    <String, dynamic>{
      'resourceState': instance.resourceState,
      'songs': instance.songs,
      'album': instance.album,
    };

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      json['picUrl'] as String,
      json['publishTime'] as int,
      json['briefDesc'] as String,
      Ar.fromJson(json['artist'] as Map<String, dynamic>),
      json['artists'] == null
          ? null
          : (json['artists'] as List<dynamic>)
              .map((e) => Ar.fromJson(e))
              .toList(),
      json['description'] as String,
      json['name'] as String,
      json['id'] as int,
      json['size'] as int,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'picUrl': instance.picUrl,
      'publishTime': instance.publishTime,
      'briefDesc': instance.briefDesc,
      'artist': instance.artist,
      'artists': instance.artists,
      'description': instance.description,
      'name': instance.name,
      'id': instance.id,
      'size': instance.size,
    };
