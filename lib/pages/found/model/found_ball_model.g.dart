// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'found_ball_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ball _$BallFromJson(Map<String, dynamic> json) => Ball(
      json['id'] as int,
      json['name'] as String,
      json['iconUrl'] as String,
      json['url'] as String,
      json['skinSupport'] as bool,
      json['homepageMode'] as String,
    );

Map<String, dynamic> _$BallToJson(Ball instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconUrl': instance.iconUrl,
      'url': instance.url,
      'skinSupport': instance.skinSupport,
      'homepageMode': instance.homepageMode,
    };
