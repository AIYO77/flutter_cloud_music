import 'package:json_annotation/json_annotation.dart';

part 'comment_response.g.dart';

@JsonSerializable()
class CommentResponse extends Object {
  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'comments')
  List<Comment> comments;

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'more')
  bool more;

  CommentResponse(
    this.code,
    this.comments,
    this.total,
    this.more,
  );

  factory CommentResponse.fromJson(Map<String, dynamic> srcJson) =>
      _$CommentResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}

@JsonSerializable()
class Comment extends Object {
  @JsonKey(name: 'commentUser')
  CommentUser commentUser;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'commentId')
  int commentId;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'time')
  int time;

  @JsonKey(name: 'timeStr')
  String timeStr;

  @JsonKey(name: 'likedCount')
  int likedCount;

  @JsonKey(name: 'liked')
  bool liked;

  Comment(
    this.commentUser,
    this.status,
    this.commentId,
    this.content,
    this.time,
    this.timeStr,
    this.likedCount,
    this.liked,
  );

  factory Comment.fromJson(Map<String, dynamic> srcJson) =>
      _$CommentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
class CommentUser extends Object {
  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'followed')
  bool followed;

  @JsonKey(name: 'mutual')
  bool mutual;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avatarUrl')
  String avatarUrl;

  @JsonKey(name: 'authStatus')
  int authStatus;

  CommentUser(
    this.userId,
    this.followed,
    this.mutual,
    this.nickname,
    this.avatarUrl,
    this.authStatus,
  );

  factory CommentUser.fromJson(Map<String, dynamic> srcJson) =>
      _$CommentUserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentUserToJson(this);
}
