// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_suggest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSuggest _$SearchSuggestFromJson(Map<String, dynamic> json) =>
    SearchSuggest(
      json['keyword'] as String,
      json['type'] as int,
      json['alg'] as String,
      json['lastKeyword'] as String,
      json['feature'] as String,
    );

Map<String, dynamic> _$SearchSuggestToJson(SearchSuggest instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'type': instance.type,
      'alg': instance.alg,
      'lastKeyword': instance.lastKeyword,
      'feature': instance.feature,
    };
