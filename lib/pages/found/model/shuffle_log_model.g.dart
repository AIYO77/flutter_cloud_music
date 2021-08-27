// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shuffle_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShuffleLogModel _$ShuffleLogModelFromJson(Map<String, dynamic> json) =>
    ShuffleLogModel(
      json['id'] as String,
      json['type'] as int,
      json['mlogBaseDataType'] as int,
      json['sameCity'] as bool,
      MLogResource.fromJson(json['resource'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShuffleLogModelToJson(ShuffleLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'mlogBaseDataType': instance.mlogBaseDataType,
      'sameCity': instance.sameCity,
      'resource': instance.resource,
    };

MLogResource _$MLogResourceFromJson(Map<String, dynamic> json) => MLogResource(
      MlogBaseData.fromJson(json['mlogBaseData'] as Map<String, dynamic>),
      MlogExtVO.fromJson(json['mlogExtVO'] as Map<String, dynamic>),
      json['shareUrl'] as String,
    );

Map<String, dynamic> _$MLogResourceToJson(MLogResource instance) =>
    <String, dynamic>{
      'mlogBaseData': instance.mlogBaseData,
      'mlogExtVO': instance.mlogExtVO,
      'shareUrl': instance.shareUrl,
    };

MlogBaseData _$MlogBaseDataFromJson(Map<String, dynamic> json) => MlogBaseData(
      json['id'] as String,
      json['type'] as int,
      json['text'] as String,
      json['coverUrl'] as String,
      json['duration'] as int,
    );

Map<String, dynamic> _$MlogBaseDataToJson(MlogBaseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'text': instance.text,
      'coverUrl': instance.coverUrl,
      'duration': instance.duration,
    };

MlogExtVO _$MlogExtVOFromJson(Map<String, dynamic> json) => MlogExtVO(
      json['likedCount'] as int,
      json['commentCount'] as int,
      json['playCount'] as int,
      json['canCollect'] as bool,
    );

Map<String, dynamic> _$MlogExtVOToJson(MlogExtVO instance) => <String, dynamic>{
      'likedCount': instance.likedCount,
      'commentCount': instance.commentCount,
      'playCount': instance.playCount,
      'canCollect': instance.canCollect,
    };
