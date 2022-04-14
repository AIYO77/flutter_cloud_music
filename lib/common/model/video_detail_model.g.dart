// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoDetailModel _$VideoDetailModelFromJson(Map<String, dynamic> json) =>
    VideoDetailModel(
      json['vid'] as String,
      VideoCreator.fromJson(json['creator'] as Map<String, dynamic>),
      json['coverUrl'] as String,
      json['title'] as String,
      json['description'] as String?,
      json['durationms'] as int,
      json['playTime'] as int,
      json['praisedCount'] as int,
      json['commentCount'] as int,
      json['shareCount'] as int,
      json['subscribeCount'] as int,
      json['publishTime'] as int,
      json['avatarUrl'] as String,
      json['width'] as int,
      json['height'] as int,
    );

Map<String, dynamic> _$VideoDetailModelToJson(VideoDetailModel instance) =>
    <String, dynamic>{
      'vid': instance.vid,
      'creator': instance.creator,
      'coverUrl': instance.coverUrl,
      'title': instance.title,
      'description': instance.description,
      'durationms': instance.durationms,
      'playTime': instance.playTime,
      'praisedCount': instance.praisedCount,
      'commentCount': instance.commentCount,
      'shareCount': instance.shareCount,
      'subscribeCount': instance.subscribeCount,
      'publishTime': instance.publishTime,
      'avatarUrl': instance.avatarUrl,
      'width': instance.width,
      'height': instance.height,
    };

VideoCreator _$VideoCreatorFromJson(Map<String, dynamic> json) => VideoCreator(
      json['followed'] as bool,
      json['userId'] as int,
      json['nickname'] as String,
      json['avatarUrl'] as String,
      json['avatarDetail'] == null
          ? null
          : AvatarDetail.fromJson(json['avatarDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoCreatorToJson(VideoCreator instance) =>
    <String, dynamic>{
      'followed': instance.followed,
      'userId': instance.userId,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'avatarDetail': instance.avatarDetail,
    };
