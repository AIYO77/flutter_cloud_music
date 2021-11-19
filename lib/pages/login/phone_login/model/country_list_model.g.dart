// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryListModel _$CountryListModelFromJson(Map<String, dynamic> json) =>
    CountryListModel(
      json['label'] as String,
      (json['countryList'] as List<dynamic>)
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryListModelToJson(CountryListModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'countryList': instance.countryList,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      json['zh'] as String,
      json['en'] as String,
      json['locale'] as String,
      json['code'] as String,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'zh': instance.zh,
      'en': instance.en,
      'locale': instance.locale,
      'code': instance.code,
    };
