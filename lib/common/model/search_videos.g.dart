// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_videos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchVideos _$SearchVideosFromJson(Map<String, dynamic> json) => SearchVideos(
      json['videoCount'] as int,
      json['hasMore'] as bool,
      (json['videos'] as List<dynamic>)
          .map((e) => Videos.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchVideosToJson(SearchVideos instance) =>
    <String, dynamic>{
      'videoCount': instance.videoCount,
      'hasMore': instance.hasMore,
      'videos': instance.videos,
    };

Videos _$VideosFromJson(Map<String, dynamic> json) => Videos(
      json['coverUrl'] as String,
      json['title'] as String,
      json['durationms'] as int,
      json['playTime'] as int,
      json['type'] as int,
      (json['creator'] as List<dynamic>)
          .map((e) => Creator.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['vid'] as String,
      json['alg'] as String,
    );

Map<String, dynamic> _$VideosToJson(Videos instance) => <String, dynamic>{
      'coverUrl': instance.coverUrl,
      'title': instance.title,
      'durationms': instance.durationms,
      'playTime': instance.playTime,
      'type': instance.type,
      'creator': instance.creator,
      'vid': instance.vid,
      'alg': instance.alg,
    };

Creator _$CreatorFromJson(Map<String, dynamic> json) => Creator(
      json['userId'] as int,
      json['userName'] as String?,
      json['nickname'] as String?,
    );

Map<String, dynamic> _$CreatorToJson(Creator instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'nickname': instance.nickname,
    };
