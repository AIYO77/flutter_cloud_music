// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_play_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimplePlayListModel _$SimplePlayListModelFromJson(Map<String, dynamic> json) =>
    SimplePlayListModel(
      json['id'] as int,
      json['name'] as String,
      json['picUrl'] as String?,
      json['coverImgUrl'] as String?,
      json['playCount'] as int,
      json['updateTime'] as int?,
    );

Map<String, dynamic> _$SimplePlayListModelToJson(
        SimplePlayListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'coverImgUrl': instance.coverImgUrl,
      'playCount': instance.playCount,
      'updateTime': instance.updateTime,
    };
