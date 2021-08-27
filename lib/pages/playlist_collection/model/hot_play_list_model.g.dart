// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_play_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotPlayListModel _$HotPlayListModelFromJson(Map<String, dynamic> json) =>
    HotPlayListModel(
      (json['tags'] as List<dynamic>)
          .map((e) => PlayListTagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HotPlayListModelToJson(HotPlayListModel instance) =>
    <String, dynamic>{
      'tags': instance.tags,
    };
