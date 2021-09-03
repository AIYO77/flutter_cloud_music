import 'package:json_annotation/json_annotation.dart';

part 'simple_play_list_model.g.dart';

@JsonSerializable()
class SimplePlayListModel extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'picUrl')
  String? picUrl;

  @JsonKey(name: 'coverImgUrl')
  String? coverImgUrl;

  @JsonKey(name: 'playCount')
  int playCount;

  @JsonKey(name: 'updateTime')
  int? updateTime;

  SimplePlayListModel(
    this.id,
    this.name,
    this.picUrl,
    this.coverImgUrl,
    this.playCount,
    this.updateTime,
  );

  factory SimplePlayListModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SimplePlayListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SimplePlayListModelToJson(this);

  String getCoverUrl() {
    return picUrl ?? coverImgUrl ?? "";
  }
}
