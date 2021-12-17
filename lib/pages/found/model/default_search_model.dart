import 'package:json_annotation/json_annotation.dart';

part 'default_search_model.g.dart';

@JsonSerializable()
class DefaultSearchModel extends Object {
  @JsonKey(name: 'showKeyword')
  String? showKeyword;

  @JsonKey(name: 'realkeyword')
  String? realkeyword;

  @JsonKey(name: 'searchType')
  int? searchType;

  DefaultSearchModel(
    this.showKeyword,
    this.realkeyword,
    this.searchType,
  );

  factory DefaultSearchModel.fromJson(Map<String, dynamic> srcJson) =>
      _$DefaultSearchModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DefaultSearchModelToJson(this);
}
