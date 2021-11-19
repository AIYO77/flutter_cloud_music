import 'package:json_annotation/json_annotation.dart';

part 'country_list_model.g.dart';

@JsonSerializable()
class CountryListModel extends Object {
  @JsonKey(name: 'label')
  String label;

  @JsonKey(name: 'countryList')
  List<Country> countryList;

  CountryListModel(
    this.label,
    this.countryList,
  );

  factory CountryListModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CountryListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CountryListModelToJson(this);
}

@JsonSerializable()
class Country extends Object {
  @JsonKey(name: 'zh')
  String zh;

  @JsonKey(name: 'en')
  String en;

  @JsonKey(name: 'locale')
  String locale;

  @JsonKey(name: 'code')
  String code;

  Country(
    this.zh,
    this.en,
    this.locale,
    this.code,
  );

  factory Country.fromJson(Map<String, dynamic> srcJson) =>
      _$CountryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
