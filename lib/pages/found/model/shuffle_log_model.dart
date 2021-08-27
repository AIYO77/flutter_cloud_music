import 'package:json_annotation/json_annotation.dart';

part 'shuffle_log_model.g.dart';

@JsonSerializable()
class ShuffleLogModel extends Object {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'mlogBaseDataType')
  int mlogBaseDataType;

  @JsonKey(name: 'sameCity')
  bool sameCity;

  @JsonKey(name: 'resource')
  MLogResource resource;

  ShuffleLogModel(
    this.id,
    this.type,
    this.mlogBaseDataType,
    this.sameCity,
    this.resource,
  );

  factory ShuffleLogModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ShuffleLogModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ShuffleLogModelToJson(this);
}

@JsonSerializable()
class MLogResource extends Object {
  @JsonKey(name: 'mlogBaseData')
  MlogBaseData mlogBaseData;

  @JsonKey(name: 'mlogExtVO')
  MlogExtVO mlogExtVO;

  @JsonKey(name: 'shareUrl')
  String shareUrl;

  MLogResource(
    this.mlogBaseData,
    this.mlogExtVO,
    this.shareUrl,
  );

  factory MLogResource.fromJson(Map<String, dynamic> srcJson) =>
      _$MLogResourceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MLogResourceToJson(this);
}

@JsonSerializable()
class MlogBaseData extends Object {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'text')
  String text;

  @JsonKey(name: 'coverUrl')
  String coverUrl;

  @JsonKey(name: 'duration')
  int duration;

  MlogBaseData(
    this.id,
    this.type,
    this.text,
    this.coverUrl,
    this.duration,
  );

  factory MlogBaseData.fromJson(Map<String, dynamic> srcJson) =>
      _$MlogBaseDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MlogBaseDataToJson(this);
}

@JsonSerializable()
class MlogExtVO extends Object {
  @JsonKey(name: 'likedCount')
  int likedCount;

  @JsonKey(name: 'commentCount')
  int commentCount;

  @JsonKey(name: 'playCount')
  int playCount;

  @JsonKey(name: 'canCollect')
  bool canCollect;

  MlogExtVO(
    this.likedCount,
    this.commentCount,
    this.playCount,
    this.canCollect,
  );

  factory MlogExtVO.fromJson(Map<String, dynamic> srcJson) =>
      _$MlogExtVOFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MlogExtVOToJson(this);
}
