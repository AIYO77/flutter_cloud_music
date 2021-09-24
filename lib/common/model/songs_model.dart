import 'package:flutter_cloud_music/common/model/privilege_model.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'songs_model.g.dart';

@JsonSerializable()
class SongsModel extends Object {
  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'songs')
  List<Song> songs;

  @JsonKey(name: 'privileges')
  List<PrivilegeModel> privileges;

  SongsModel(
    this.code,
    this.songs,
    this.privileges,
  );

  factory SongsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SongsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SongsModelToJson(this);
}
