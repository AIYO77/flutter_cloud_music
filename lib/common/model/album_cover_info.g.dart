// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_cover_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumCoverInfo _$AlbumCoverInfoFromJson(Map<String, dynamic> json) =>
    AlbumCoverInfo(
      json['albumId'] as int,
      json['albumName'] as String,
      json['artistName'] as String,
      json['coverUrl'] as String,
    );

Map<String, dynamic> _$AlbumCoverInfoToJson(AlbumCoverInfo instance) =>
    <String, dynamic>{
      'albumId': instance.albumId,
      'albumName': instance.albumName,
      'artistName': instance.artistName,
      'coverUrl': instance.coverUrl,
    };
