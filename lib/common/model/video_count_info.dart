/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/24 11:24 上午
/// Des:
import 'package:json_annotation/json_annotation.dart';

part 'video_count_info.g.dart';

@JsonSerializable()
class VideoCountInfo extends Object {
  @JsonKey(name: 'likedCount')
  int likedCount;

  @JsonKey(name: 'shareCount')
  int shareCount;

  @JsonKey(name: 'commentCount')
  int commentCount;

  VideoCountInfo(
    this.likedCount,
    this.shareCount,
    this.commentCount,
  );

  factory VideoCountInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$VideoCountInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoCountInfoToJson(this);
}
