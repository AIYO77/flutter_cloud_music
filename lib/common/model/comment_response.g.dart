// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) =>
    CommentResponse(
      json['code'] as int,
      (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int,
      json['more'] as bool,
    );

Map<String, dynamic> _$CommentResponseToJson(CommentResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'comments': instance.comments,
      'total': instance.total,
      'more': instance.more,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      CommentUser.fromJson(json['commentUser'] as Map<String, dynamic>),
      json['status'] as int,
      json['commentId'] as int,
      json['content'] as String,
      json['time'] as int,
      json['timeStr'] as String,
      json['likedCount'] as int,
      json['liked'] as bool,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'commentUser': instance.commentUser,
      'status': instance.status,
      'commentId': instance.commentId,
      'content': instance.content,
      'time': instance.time,
      'timeStr': instance.timeStr,
      'likedCount': instance.likedCount,
      'liked': instance.liked,
    };

CommentUser _$CommentUserFromJson(Map<String, dynamic> json) => CommentUser(
      json['userId'] as int,
      json['followed'] as bool,
      json['mutual'] as bool,
      json['nickname'] as String,
      json['avatarUrl'] as String,
      json['authStatus'] as int,
    );

Map<String, dynamic> _$CommentUserToJson(CommentUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'followed': instance.followed,
      'mutual': instance.mutual,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'authStatus': instance.authStatus,
    };
