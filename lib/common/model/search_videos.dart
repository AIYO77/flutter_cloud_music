/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/14 7:42 下午
/// Des:
import 'package:json_annotation/json_annotation.dart';

part 'search_videos.g.dart';

@JsonSerializable()
class SearchVideos extends Object {
  @JsonKey(name: 'videoCount')
  int videoCount;

  @JsonKey(name: 'hasMore')
  bool hasMore;

  @JsonKey(name: 'videos')
  List<Videos> videos;

  SearchVideos(
    this.videoCount,
    this.hasMore,
    this.videos,
  );

  factory SearchVideos.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchVideosFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchVideosToJson(this);
}

@JsonSerializable()
class Videos extends Object {
  @JsonKey(name: 'coverUrl')
  String coverUrl;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'durationms')
  int durationms;

  @JsonKey(name: 'playTime')
  int playTime;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'creator')
  List<Creator> creator;

  @JsonKey(name: 'vid')
  String vid;

  @JsonKey(name: 'alg')
  String alg;

  Videos(
    this.coverUrl,
    this.title,
    this.durationms,
    this.playTime,
    this.type,
    this.creator,
    this.vid,
    this.alg,
  );

  factory Videos.fromJson(Map<String, dynamic> srcJson) =>
      _$VideosFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideosToJson(this);
}

@JsonSerializable()
class Creator extends Object {
  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'userName')
  String? userName;

  @JsonKey(name: 'nickname')
  String? nickname;

  Creator(
    this.userId,
    this.userName,
    this.nickname,
  );

  factory Creator.fromJson(Map<String, dynamic> srcJson) =>
      _$CreatorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CreatorToJson(this);

  String get name => userName ?? nickname ?? '佚名';
}
