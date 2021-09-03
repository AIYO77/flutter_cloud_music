// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creative_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreativeModel _$CreativeModelFromJson(Map<String, dynamic> json) =>
    CreativeModel(
      json['creativeType'] as String?,
      json['action'] as String?,
      json['uiElement'] == null
          ? null
          : UiElementModel.fromJson(json['uiElement'] as Map<String, dynamic>),
      json['creativeExtInfoVO'],
      (json['resources'] as List<dynamic>?)
          ?.map((e) => Resources.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['algReason'] as String?,
    );

Map<String, dynamic> _$CreativeModelToJson(CreativeModel instance) =>
    <String, dynamic>{
      'creativeType': instance.creativeType,
      'action': instance.action,
      'resources': instance.resources,
      'uiElement': instance.uiElement,
      'creativeExtInfoVO': instance.creativeExtInfoVO,
      'algReason': instance.algReason,
    };

Resources _$ResourcesFromJson(Map<String, dynamic> json) => Resources(
      UiElementModel.fromJson(json['uiElement'] as Map<String, dynamic>),
      json['resourceType'] as String?,
      json['resourceId'] as String?,
      json['resourceExtInfo'],
      json['action'] as String?,
      json['actionType'] as String?,
      json['valid'] as bool,
    );

Map<String, dynamic> _$ResourcesToJson(Resources instance) => <String, dynamic>{
      'uiElement': instance.uiElement,
      'resourceType': instance.resourceType,
      'resourceId': instance.resourceId,
      'resourceExtInfo': instance.resourceExtInfo,
      'action': instance.action,
      'actionType': instance.actionType,
      'valid': instance.valid,
    };

ResourceExtInfoModel _$ResourceExtInfoModelFromJson(
        Map<String, dynamic> json) =>
    ResourceExtInfoModel(
      json['playCount'] as int,
      json['highQuality'] as bool,
      (json['users'] as List<dynamic>?)
          ?.map((e) => UserInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['specialCover'] as int?,
      json['specialType'] as int?,
    );

Map<String, dynamic> _$ResourceExtInfoModelToJson(
        ResourceExtInfoModel instance) =>
    <String, dynamic>{
      'playCount': instance.playCount,
      'highQuality': instance.highQuality,
      'users': instance.users,
      'specialCover': instance.specialCover,
      'specialType': instance.specialType,
    };
