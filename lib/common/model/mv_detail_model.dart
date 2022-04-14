/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/25 2:58 下午
/// Des:
import 'package:flutter_cloud_music/common/model/video_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mv_detail_model.g.dart';

@JsonSerializable()
class MvDetailModel extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'artistId')
  int artistId;

  @JsonKey(name: 'artistName')
  String artistName;

  @JsonKey(name: 'briefDesc')
  String briefDesc;

  @JsonKey(name: 'desc')
  String? desc;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'playCount')
  int playCount;

  @JsonKey(name: 'subCount')
  int subCount;

  @JsonKey(name: 'shareCount')
  int shareCount;

  @JsonKey(name: 'commentCount')
  int commentCount;

  @JsonKey(name: 'duration')
  int duration;

  @JsonKey(name: 'artists')
  List<MvArtists> artists;

  @JsonKey(name: 'alias')
  List<String>? alias;

  @JsonKey(name: 'commentThreadId')
  String commentThreadId;

  MvDetailModel(
    this.id,
    this.name,
    this.artistId,
    this.artistName,
    this.briefDesc,
    this.desc,
    this.cover,
    this.playCount,
    this.subCount,
    this.shareCount,
    this.commentCount,
    this.duration,
    this.artists,
    this.alias,
    this.commentThreadId,
  );

  factory MvDetailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$MvDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MvDetailModelToJson(this);
}

@JsonSerializable()
class MvArtists extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'followed')
  bool followed;

  @JsonKey(name: 'img1v1Url')
  String? img1v1Url;

  MvArtists(
    this.id,
    this.name,
    this.followed,
    this.img1v1Url,
  );

  factory MvArtists.fromJson(Map<String, dynamic> srcJson) =>
      _$MvArtistsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MvArtistsToJson(this);
}

extension MvDetailExt on MvArtists {
  VideoCreator toVideoCreator() {
    return VideoCreator(followed, id, name, img1v1Url ?? '', null);
  }
}
