// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'singer_videos_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingerVideosModel _$SingerVideosModelFromJson(Map<String, dynamic> json) =>
    SingerVideosModel(
      (json['records'] as List<dynamic>)
          .map((e) => Records.fromJson(e as Map<String, dynamic>))
          .toList(),
      Page.fromJson(json['page'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingerVideosModelToJson(SingerVideosModel instance) =>
    <String, dynamic>{
      'records': instance.records,
      'page': instance.page,
    };

Records _$RecordsFromJson(Map<String, dynamic> json) => Records(
      json['id'] as String,
      json['type'] as int,
      MLogResource.fromJson(json['resource'] as Map<String, dynamic>),
      json['sameCity'] as bool,
    );

Map<String, dynamic> _$RecordsToJson(Records instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'resource': instance.resource,
      'sameCity': instance.sameCity,
    };

Page _$PageFromJson(Map<String, dynamic> json) => Page(
      json['size'] as int,
      json['cursor'] as String,
      json['more'] as bool,
    );

Map<String, dynamic> _$PageToJson(Page instance) => <String, dynamic>{
      'size': instance.size,
      'cursor': instance.cursor,
      'more': instance.more,
    };
