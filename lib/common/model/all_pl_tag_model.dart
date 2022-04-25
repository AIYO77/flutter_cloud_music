import 'package:flutter_cloud_music/pages/playlist_collection/model/play_list_tag_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_pl_tag_model.g.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/24 4:51 下午
/// Des:

@JsonSerializable()
class AllPlTagModel extends Object {
  @JsonKey(name: 'sub')
  List<PlayListTagModel> sub;

  @JsonKey(name: 'categories')
  Map<String, String> categories;

  AllPlTagModel(
    this.sub,
    this.categories,
  );

  factory AllPlTagModel.fromJson(Map<String, dynamic> srcJson) =>
      _$AllPlTagModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AllPlTagModelToJson(this);
}
