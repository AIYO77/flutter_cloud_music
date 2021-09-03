import 'package:flutter_cloud_music/common/model/ui_element_model.dart';
import 'package:flutter_cloud_music/common/model/user_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'creative_model.g.dart';

@JsonSerializable()
class CreativeModel extends Object {
  @JsonKey(name: 'creativeType')
  String? creativeType;

  @JsonKey(name: 'action')
  String? action;

  @JsonKey(name: 'resources')
  List<Resources>? resources;

  @JsonKey(name: 'uiElement')
  UiElementModel? uiElement;

  @JsonKey(name: 'creativeExtInfoVO')
  dynamic creativeExtInfoVO;

  @JsonKey(name: 'algReason')
  String? algReason;

  CreativeModel(
    this.creativeType,
    this.action,
    this.uiElement,
    this.creativeExtInfoVO,
    this.resources,
    this.algReason,
  );

  factory CreativeModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CreativeModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CreativeModelToJson(this);
}

@JsonSerializable()
class Resources extends Object {
  @JsonKey(name: 'uiElement')
  UiElementModel uiElement;

  @JsonKey(name: 'resourceType')
  String? resourceType;

  @JsonKey(name: 'resourceId')
  String? resourceId;

  @JsonKey(name: 'resourceExtInfo')
  dynamic resourceExtInfo;

  @JsonKey(name: 'action')
  String? action;

  @JsonKey(name: 'actionType')
  String? actionType;

  @JsonKey(name: 'valid')
  bool valid;

  Resources(
    this.uiElement,
    this.resourceType,
    this.resourceId,
    this.resourceExtInfo,
    this.action,
    this.actionType,
    this.valid,
  );

  factory Resources.fromJson(Map<String, dynamic> srcJson) =>
      _$ResourcesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResourcesToJson(this);
}

@JsonSerializable()
class ResourceExtInfoModel extends Object {
  @JsonKey(name: 'playCount')
  int playCount;

  @JsonKey(name: 'highQuality')
  bool highQuality;

  @JsonKey(name: 'users')
  List<UserInfo>? users;

  @JsonKey(name: 'specialCover')
  int? specialCover;

  @JsonKey(name: 'specialType')
  int? specialType;

  ResourceExtInfoModel(
    this.playCount,
    this.highQuality,
    this.users,
    this.specialCover,
    this.specialType,
  );

  factory ResourceExtInfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ResourceExtInfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResourceExtInfoModelToJson(this);
}
