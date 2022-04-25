import 'package:json_annotation/json_annotation.dart';

part 'play_list_tag_model.g.dart';

@JsonSerializable()
class PlayListTagModel extends Object {
  @JsonKey(name: 'activity')
  bool activity;

  @JsonKey(name: 'hot')
  bool hot;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'category')
  int category;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'usedCount')
  int? usedCount;

  PlayListTagModel(
    this.activity,
    this.hot,
    this.name,
    this.category,
    this.type,
    this.usedCount,
  );

  factory PlayListTagModel.fromJson(Map<String, dynamic> srcJson) =>
      _$PlayListTagModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PlayListTagModelToJson(this);

  @override
  String toString() {
    return '$category$name';
  }
}
