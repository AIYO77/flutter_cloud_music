// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'found_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoundData _$FoundDataFromJson(Map<String, dynamic> json) => FoundData(
      json['cursor'] as String?,
      (json['blocks'] as List<dynamic>)
          .map((e) => Blocks.fromJson(e as Map<String, dynamic>))
          .toList(),
      PageConfig.fromJson(json['pageConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FoundDataToJson(FoundData instance) => <String, dynamic>{
      'cursor': instance.cursor,
      'blocks': instance.blocks,
      'pageConfig': instance.pageConfig,
    };

Blocks _$BlocksFromJson(Map<String, dynamic> json) => Blocks(
      json['blockCode'] as String,
      json['showType'] as String,
      json['extInfo'],
      json['uiElement'] == null
          ? null
          : UiElementModel.fromJson(json['uiElement'] as Map<String, dynamic>),
      (json['creatives'] as List<dynamic>?)
          ?.map((e) => CreativeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['canClose'] as bool,
    );

Map<String, dynamic> _$BlocksToJson(Blocks instance) => <String, dynamic>{
      'blockCode': instance.blockCode,
      'showType': instance.showType,
      'extInfo': instance.extInfo,
      'uiElement': instance.uiElement,
      'creatives': instance.creatives,
      'canClose': instance.canClose,
    };

PageConfig _$PageConfigFromJson(Map<String, dynamic> json) => PageConfig(
      json['refreshToast'] as String?,
      json['nodataToast'] as String?,
      json['refreshInterval'] as int,
    );

Map<String, dynamic> _$PageConfigToJson(PageConfig instance) =>
    <String, dynamic>{
      'refreshToast': instance.refreshToast,
      'nodataToast': instance.nodataToast,
      'refreshInterval': instance.refreshInterval,
    };
