// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_pl_tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllPlTagModel _$AllPlTagModelFromJson(Map<String, dynamic> json) =>
    AllPlTagModel(
      (json['sub'] as List<dynamic>)
          .map((e) => PlayListTagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      Map<String, String>.from(json['categories'] as Map),
    );

Map<String, dynamic> _$AllPlTagModelToJson(AllPlTagModel instance) =>
    <String, dynamic>{
      'sub': instance.sub,
      'categories': instance.categories,
    };
