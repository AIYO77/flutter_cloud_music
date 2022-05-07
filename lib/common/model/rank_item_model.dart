/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/5/6 11:50 上午
/// Des:
import 'package:json_annotation/json_annotation.dart';

part 'rank_item_model.g.dart';

@JsonSerializable()
class RankItemModel extends Object {
  @JsonKey(name: 'tracks')
  List<RankTracks> tracks;

  @JsonKey(name: 'updateFrequency')
  String updateFrequency;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'subscribedCount')
  int subscribedCount;

  @JsonKey(name: 'coverImgUrl')
  String coverImgUrl;

  @JsonKey(name: 'playCount')
  int playCount;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'updateTime')
  int updateTime;

  RankItemModel(
    this.tracks,
    this.updateFrequency,
    this.userId,
    this.subscribedCount,
    this.coverImgUrl,
    this.playCount,
    this.name,
    this.id,
    this.updateTime,
  );

  factory RankItemModel.fromJson(Map<String, dynamic> srcJson) =>
      _$RankItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RankItemModelToJson(this);
}

@JsonSerializable()
class RankTracks extends Object {
  @JsonKey(name: 'first')
  String first;

  @JsonKey(name: 'second')
  String second;

  RankTracks(
    this.first,
    this.second,
  );

  factory RankTracks.fromJson(Map<String, dynamic> srcJson) =>
      _$RankTracksFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RankTracksToJson(this);
}
