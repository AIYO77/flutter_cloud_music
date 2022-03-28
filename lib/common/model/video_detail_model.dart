/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/25 3:03 下午
/// Des:
import 'package:flutter_cloud_music/common/model/user_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_detail_model.g.dart';

@JsonSerializable()
class VideoDetailModel extends Object {
  @JsonKey(name: 'vid')
  String vid;

  @JsonKey(name: 'creator')
  VideoCreator creator;

  @JsonKey(name: 'coverUrl')
  String coverUrl;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'durationms')
  int durationms;

  @JsonKey(name: 'playTime')
  int playTime;

  @JsonKey(name: 'praisedCount')
  int praisedCount;

  @JsonKey(name: 'commentCount')
  int commentCount;

  @JsonKey(name: 'shareCount')
  int shareCount;

  @JsonKey(name: 'subscribeCount')
  int subscribeCount;

  @JsonKey(name: 'publishTime')
  int publishTime;

  @JsonKey(name: 'avatarUrl')
  String avatarUrl;

  @JsonKey(name: 'width')
  int width;

  @JsonKey(name: 'height')
  int height;

  VideoDetailModel(
    this.vid,
    this.creator,
    this.coverUrl,
    this.title,
    this.description,
    this.durationms,
    this.playTime,
    this.praisedCount,
    this.commentCount,
    this.shareCount,
    this.subscribeCount,
    this.publishTime,
    this.avatarUrl,
    this.width,
    this.height,
  );

  factory VideoDetailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VideoDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoDetailModelToJson(this);
}

@JsonSerializable()
class VideoCreator extends Object {
  @JsonKey(name: 'followed')
  bool followed;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'userType')
  int userType;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avatarUrl')
  String avatarUrl;

  @JsonKey(name: 'avatarDetail')
  AvatarDetail? avatarDetail;

  VideoCreator(
    this.followed,
    this.userId,
    this.userType,
    this.nickname,
    this.avatarUrl,
    this.avatarDetail,
  );

  factory VideoCreator.fromJson(Map<String, dynamic> srcJson) =>
      _$VideoCreatorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoCreatorToJson(this);
}
