import 'package:json_annotation/json_annotation.dart';

part 'search_suggest.g.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/11 7:52 下午
/// Des:

@JsonSerializable()
class SearchSuggest extends Object {
  @JsonKey(name: 'keyword')
  String keyword;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'alg')
  String alg;

  @JsonKey(name: 'lastKeyword')
  String lastKeyword;

  @JsonKey(name: 'feature')
  String feature;

  SearchSuggest(
    this.keyword,
    this.type,
    this.alg,
    this.lastKeyword,
    this.feature,
  );

  factory SearchSuggest.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchSuggestFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchSuggestToJson(this);
}
