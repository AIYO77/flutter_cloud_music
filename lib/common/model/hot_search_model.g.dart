// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotSearchModel _$HotSearchModelFromJson(Map<String, dynamic> json) =>
    HotSearchModel(
      (json['data'] as List<dynamic>)
          .map((e) => HotSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HotSearchModelToJson(HotSearchModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

HotSearch _$HotSearchFromJson(Map<String, dynamic> json) => HotSearch(
      json['searchWord'] as String,
      json['score'] as int,
      json['content'] as String,
      json['source'] as int,
      json['iconType'] as int,
      json['iconUrl'] as String?,
      json['url'] as String,
      json['alg'] as String,
    );

Map<String, dynamic> _$HotSearchToJson(HotSearch instance) => <String, dynamic>{
      'searchWord': instance.searchWord,
      'score': instance.score,
      'content': instance.content,
      'source': instance.source,
      'iconType': instance.iconType,
      'iconUrl': instance.iconUrl,
      'url': instance.url,
      'alg': instance.alg,
    };
