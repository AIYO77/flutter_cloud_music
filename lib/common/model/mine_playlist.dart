/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/3 8:22 下午
/// Des:
import 'package:flutter_cloud_music/common/model/user_info_model.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mine_playlist.g.dart';

@JsonSerializable()
class MinePlaylist extends Object {
  @JsonKey(name: 'trackCount')
  int trackCount;

  @JsonKey(name: 'specialType')
  int specialType;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'coverImgUrl')
  String coverImgUrl;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'privacy')
  int privacy;

  @JsonKey(name: 'creator')
  UserInfo creator;

  MinePlaylist(
    this.trackCount,
    this.specialType,
    this.name,
    this.coverImgUrl,
    this.id,
    this.privacy,
    this.creator,
  );

  factory MinePlaylist.fromJson(Map<String, dynamic> srcJson) =>
      _$MinePlaylistFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MinePlaylistToJson(this);

  String getCountAndBy() {
    if (isMyPl()) {
      return '$trackCount首';
    }
    return '$trackCount首, by ${creator.nickname}';
  }

  bool isMyPl() {
    return AuthService.to.userId == creator.userId;
  }

  bool isIntelligent() {
    return specialType == 5;
  }

  bool isMineCreate() {
    return creator.userId == AuthService.to.userId && !isIntelligent();
  }
}

extension MinePlaylistExt on MinePlaylist {
  bool isVideoPl() {
    return specialType == 200;
  }
}
