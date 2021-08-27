import 'package:flutter_cloud_music/pages/playlist_collection/model/play_list_tag_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hot_play_list_model.g.dart';

@JsonSerializable()
class HotPlayListModel extends Object {
  @JsonKey(name: 'tags')
  List<PlayListTagModel> tags;

  HotPlayListModel(
    this.tags,
  );

  factory HotPlayListModel.fromJson(Map<String, dynamic> srcJson) =>
      _$HotPlayListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotPlayListModelToJson(this);
}
