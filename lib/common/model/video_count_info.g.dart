// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_count_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoCountInfo _$VideoCountInfoFromJson(Map<String, dynamic> json) =>
    VideoCountInfo(
      json['likedCount'] as int,
      json['shareCount'] as int,
      json['commentCount'] as int,
    );

Map<String, dynamic> _$VideoCountInfoToJson(VideoCountInfo instance) =>
    <String, dynamic>{
      'likedCount': instance.likedCount,
      'shareCount': instance.shareCount,
      'commentCount': instance.commentCount,
    };
