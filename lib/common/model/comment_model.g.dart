// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalCount'] as int,
      json['hasMore'] as bool,
      json['cursor'] as String,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'comments': instance.comments,
      'totalCount': instance.totalCount,
      'hasMore': instance.hasMore,
      'cursor': instance.cursor,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      CommentUser.fromJson(json['user'] as Map<String, dynamic>),
      json['commentId'] as int,
      json['content'] as String,
      json['time'] as int,
      json['timeStr'] as String,
      json['needDisplayTime'] as bool,
      json['likedCount'] as int,
      json['liked'] as bool,
      json['parentCommentId'] as int,
      json['showFloorComment'] == null
          ? null
          : ShowFloorComment.fromJson(
              json['showFloorComment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'user': instance.user,
      'commentId': instance.commentId,
      'content': instance.content,
      'time': instance.time,
      'timeStr': instance.timeStr,
      'needDisplayTime': instance.needDisplayTime,
      'likedCount': instance.likedCount,
      'liked': instance.liked,
      'parentCommentId': instance.parentCommentId,
      'showFloorComment': instance.showFloorComment,
    };

CommentUser _$CommentUserFromJson(Map<String, dynamic> json) => CommentUser(
      json['followed'] as bool,
      json['userId'] as int,
      json['nickname'] as String,
      json['avatarUrl'] as String,
      json['avatarDetail'] == null
          ? null
          : AvatarDetail.fromJson(json['avatarDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentUserToJson(CommentUser instance) =>
    <String, dynamic>{
      'followed': instance.followed,
      'userId': instance.userId,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'avatarDetail': instance.avatarDetail,
    };

ShowFloorComment _$ShowFloorCommentFromJson(Map<String, dynamic> json) =>
    ShowFloorComment(
      json['replyCount'] as int,
      (json['comments'] as List<dynamic>?)
          ?.map((e) => RepliedComment.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['showReplyCount'] as bool,
    );

Map<String, dynamic> _$ShowFloorCommentToJson(ShowFloorComment instance) =>
    <String, dynamic>{
      'replyCount': instance.replyCount,
      'comments': instance.comments,
      'showReplyCount': instance.showReplyCount,
    };

RepliedComment _$RepliedCommentFromJson(Map<String, dynamic> json) =>
    RepliedComment(
      CommentUser.fromJson(json['user'] as Map<String, dynamic>),
      CommentUser.fromJson(json['beRepliedUser'] as Map<String, dynamic>),
      json['commentId'] as int,
      json['beRepliedCommentId'] as int,
      json['content'] as String,
    );

Map<String, dynamic> _$RepliedCommentToJson(RepliedComment instance) =>
    <String, dynamic>{
      'user': instance.user,
      'beRepliedUser': instance.beRepliedUser,
      'commentId': instance.commentId,
      'beRepliedCommentId': instance.beRepliedCommentId,
      'content': instance.content,
    };
