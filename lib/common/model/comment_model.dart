import 'package:flutter_cloud_music/common/model/user_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/6 7:47 下午
/// Des:
part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends Object {
  @JsonKey(name: 'comments')
  List<Comment> comments;

  @JsonKey(name: 'totalCount')
  int totalCount;

  @JsonKey(name: 'hasMore')
  bool hasMore;

  @JsonKey(name: 'cursor')
  String cursor;

  CommentModel(
    this.comments,
    this.totalCount,
    this.hasMore,
    this.cursor,
  );

  factory CommentModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CommentModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}

@JsonSerializable()
class Comment extends Object {
  @JsonKey(name: 'user')
  CommentUser user;

  @JsonKey(name: 'commentId')
  int commentId;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'time')
  int time;

  @JsonKey(name: 'timeStr')
  String timeStr;

  @JsonKey(name: 'needDisplayTime')
  bool needDisplayTime;

  @JsonKey(name: 'likedCount')
  int likedCount;

  @JsonKey(name: 'liked')
  bool liked;

  @JsonKey(name: 'parentCommentId')
  int parentCommentId;

  @JsonKey(name: 'showFloorComment')
  ShowFloorComment? showFloorComment;

  Comment(
    this.user,
    this.commentId,
    this.content,
    this.time,
    this.timeStr,
    this.needDisplayTime,
    this.likedCount,
    this.liked,
    this.parentCommentId,
    this.showFloorComment,
  );

  factory Comment.fromJson(Map<String, dynamic> srcJson) =>
      _$CommentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
class CommentUser extends Object {
  @JsonKey(name: 'followed')
  bool followed;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avatarUrl')
  String avatarUrl;

  @JsonKey(name: 'avatarDetail')
  AvatarDetail? avatarDetail;

  CommentUser(
    this.followed,
    this.userId,
    this.nickname,
    this.avatarUrl,
    this.avatarDetail,
  );

  factory CommentUser.fromJson(Map<String, dynamic> srcJson) =>
      _$CommentUserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentUserToJson(this);
}

@JsonSerializable()
class ShowFloorComment extends Object {
  @JsonKey(name: 'replyCount')
  int replyCount;

  @JsonKey(name: 'comments')
  List<RepliedComment>? comments;

  @JsonKey(name: 'showReplyCount')
  bool showReplyCount;

  ShowFloorComment(
    this.replyCount,
    this.comments,
    this.showReplyCount,
  );

  factory ShowFloorComment.fromJson(Map<String, dynamic> srcJson) =>
      _$ShowFloorCommentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ShowFloorCommentToJson(this);
}

@JsonSerializable()
class RepliedComment extends Object {
  @JsonKey(name: 'user')
  CommentUser user;

  @JsonKey(name: 'beRepliedUser')
  CommentUser beRepliedUser;

  @JsonKey(name: 'commentId')
  int commentId;

  @JsonKey(name: 'beRepliedCommentId')
  int beRepliedCommentId;

  @JsonKey(name: 'content')
  String content;

  RepliedComment(
    this.user,
    this.beRepliedUser,
    this.commentId,
    this.beRepliedCommentId,
    this.content,
  );

  factory RepliedComment.fromJson(Map<String, dynamic> srcJson) =>
      _$RepliedCommentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RepliedCommentToJson(this);
}
