import 'package:json_annotation/json_annotation.dart';

part 'album_dynamic_info.g.dart';

@JsonSerializable()
class AlbumDynamicInfo extends Object {
  @JsonKey(name: 'commentCount')
  int commentCount;

  @JsonKey(name: 'likedCount')
  int likedCount;

  @JsonKey(name: 'shareCount')
  int shareCount;

  @JsonKey(name: 'isSub')
  bool isSub;

  @JsonKey(name: 'subCount')
  int subCount;

  AlbumDynamicInfo(
    this.commentCount,
    this.likedCount,
    this.shareCount,
    this.isSub,
    this.subCount,
  );

  factory AlbumDynamicInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$AlbumDynamicInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlbumDynamicInfoToJson(this);
}
