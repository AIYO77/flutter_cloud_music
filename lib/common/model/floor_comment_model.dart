/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/15 10:29 上午
/// Des:
import 'package:flutter_cloud_music/common/model/comment_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'floor_comment_model.g.dart';

@JsonSerializable()
class FloorCommentModel extends Object {
  @JsonKey(name: 'ownerComment')
  Comment ownerComment;

  @JsonKey(name: 'comments')
  List<Comment> comments;

  @JsonKey(name: 'hasMore')
  bool hasMore;

  @JsonKey(name: 'totalCount')
  int totalCount;

  @JsonKey(name: 'time')
  int time;

  @JsonKey(name: 'bestComments')
  List<Comment>? bestComments;

  FloorCommentModel(
    this.ownerComment,
    this.comments,
    this.hasMore,
    this.totalCount,
    this.time,
    this.bestComments,
  );

  factory FloorCommentModel.fromJson(Map<String, dynamic> srcJson) =>
      _$FloorCommentModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FloorCommentModelToJson(this);
}
