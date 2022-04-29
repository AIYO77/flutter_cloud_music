/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/26 5:38 下午
/// Des:
import 'package:json_annotation/json_annotation.dart';

part 'hot_search_model.g.dart';

@JsonSerializable()
class HotSearchModel extends Object {
  @JsonKey(name: 'data')
  List<HotSearch> data;

  HotSearchModel(
    this.data,
  );

  factory HotSearchModel.fromJson(Map<String, dynamic> srcJson) =>
      _$HotSearchModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotSearchModelToJson(this);
}

@JsonSerializable()
class HotSearch extends Object {
  @JsonKey(name: 'searchWord')
  String searchWord;

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'source')
  int source;

  @JsonKey(name: 'iconType')
  int iconType;

  @JsonKey(name: 'iconUrl')
  String? iconUrl;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'alg')
  String alg;

  HotSearch(
    this.searchWord,
    this.score,
    this.content,
    this.source,
    this.iconType,
    this.iconUrl,
    this.url,
    this.alg,
  );

  factory HotSearch.fromJson(Map<String, dynamic> srcJson) =>
      _$HotSearchFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotSearchToJson(this);
}
