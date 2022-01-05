// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_dynamic_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumDynamicInfo _$AlbumDynamicInfoFromJson(Map<String, dynamic> json) =>
    AlbumDynamicInfo(
      json['commentCount'] as int,
      json['likedCount'] as int,
      json['shareCount'] as int,
      json['isSub'] as bool,
      json['subCount'] as int,
    );

Map<String, dynamic> _$AlbumDynamicInfoToJson(AlbumDynamicInfo instance) =>
    <String, dynamic>{
      'commentCount': instance.commentCount,
      'likedCount': instance.likedCount,
      'shareCount': instance.shareCount,
      'isSub': instance.isSub,
      'subCount': instance.subCount,
    };
