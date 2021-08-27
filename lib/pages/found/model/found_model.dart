import 'package:flutter_cloud_music/common/model/ui_element_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'creative_model.dart';

part 'found_model.g.dart';

@JsonSerializable()
class FoundData extends Object {
  @JsonKey(name: 'blocks')
  List<Blocks> blocks;

  @JsonKey(name: 'pageConfig')
  PageConfig pageConfig;

  FoundData(
    this.blocks,
    this.pageConfig,
  );

  factory FoundData.fromJson(Map<String, dynamic> srcJson) =>
      _$FoundDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FoundDataToJson(this);
}

@JsonSerializable()
class Blocks extends Object {
  @JsonKey(name: 'blockCode')
  String blockCode;

  @JsonKey(name: 'showType')
  String showType;

  @JsonKey(name: 'extInfo')
  dynamic extInfo;

  @JsonKey(name: 'uiElement')
  UiElementModel? uiElement;

  @JsonKey(name: 'creatives')
  List<CreativeModel>? creatives;

  @JsonKey(name: 'canClose')
  bool canClose;

  Blocks(
    this.blockCode,
    this.showType,
    this.extInfo,
    this.uiElement,
    this.creatives,
    this.canClose,
  );

  factory Blocks.fromJson(Map<String, dynamic> srcJson) =>
      _$BlocksFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BlocksToJson(this);
}

@JsonSerializable()
class PageConfig extends Object {
  @JsonKey(name: 'refreshToast')
  String? refreshToast;

  @JsonKey(name: 'nodataToast')
  String? nodataToast;

  @JsonKey(name: 'refreshInterval')
  int refreshInterval;

  PageConfig(
    this.refreshToast,
    this.nodataToast,
    this.refreshInterval,
  );

  factory PageConfig.fromJson(Map<String, dynamic> srcJson) =>
      _$PageConfigFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PageConfigToJson(this);
}
