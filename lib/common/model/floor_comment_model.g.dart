// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorCommentModel _$FloorCommentModelFromJson(Map<String, dynamic> json) =>
    FloorCommentModel(
      Comment.fromJson(json['ownerComment'] as Map<String, dynamic>),
      (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['hasMore'] as bool,
      json['totalCount'] as int,
      json['time'] as int,
      (json['bestComments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FloorCommentModelToJson(FloorCommentModel instance) =>
    <String, dynamic>{
      'ownerComment': instance.ownerComment,
      'comments': instance.comments,
      'hasMore': instance.hasMore,
      'totalCount': instance.totalCount,
      'time': instance.time,
      'bestComments': instance.bestComments,
    };
