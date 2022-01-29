import 'package:flutter_cloud_music/common/model/singer_detail_model.dart';
import 'package:flutter_cloud_music/pages/singer_detail/state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_detail_model.g.dart';

@JsonSerializable()
class UserDetailModel extends Object {
  @JsonKey(name: 'identify')
  Identify? identify;

  @JsonKey(name: 'level')
  int level;

  @JsonKey(name: 'listenSongs')
  int listenSongs;

  @JsonKey(name: 'profile')
  Profile profile;

  @JsonKey(name: 'createTime')
  int createTime;

  @JsonKey(name: 'createDays')
  int createDays;

  @JsonKey(name: 'profileVillageInfo')
  ProfileVillageInfo? profileVillageInfo;

  UserDetailModel(
    this.identify,
    this.level,
    this.listenSongs,
    this.profile,
    this.createTime,
    this.createDays,
    this.profileVillageInfo,
  );

  factory UserDetailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$UserDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserDetailModelToJson(this);

  SingerOrUserDetail? _detail;

  SingerOrUserDetail get detail {
    _detail ??= SingerOrUserDetail(profile.artistId != null, null, this);
    return _detail!;
  }
}

@JsonSerializable()
class Profile extends Object {
  @JsonKey(name: 'userType')
  int userType;

  @JsonKey(name: 'authStatus')
  int authStatus;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'birthday')
  int birthday;

  @JsonKey(name: 'gender')
  int gender;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avatarUrl')
  String avatarUrl;

  @JsonKey(name: 'backgroundUrl')
  String backgroundUrl;

  @JsonKey(name: 'city')
  int city;

  @JsonKey(name: 'followed')
  bool followed;

  @JsonKey(name: 'signature')
  String signature;

  @JsonKey(name: 'followeds')
  int followeds;

  @JsonKey(name: 'follows')
  int follows;

  @JsonKey(name: 'eventCount')
  int eventCount;

  @JsonKey(name: 'followMe')
  bool followMe;

  @JsonKey(name: 'playlistCount')
  int playlistCount;

  @JsonKey(name: 'artistId')
  int? artistId;

  @JsonKey(name: 'artistName')
  String? artistName;

  Profile(
    this.userType,
    this.authStatus,
    this.description,
    this.userId,
    this.birthday,
    this.gender,
    this.nickname,
    this.avatarUrl,
    this.backgroundUrl,
    this.city,
    this.followed,
    this.signature,
    this.followeds,
    this.follows,
    this.eventCount,
    this.followMe,
    this.playlistCount,
    this.artistId,
    this.artistName,
  );

  factory Profile.fromJson(Map<String, dynamic> srcJson) =>
      _$ProfileFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class ProfileVillageInfo extends Object {
  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'imageUrl')
  String imageUrl;

  @JsonKey(name: 'targetUrl')
  String? targetUrl;

  ProfileVillageInfo(
    this.title,
    this.imageUrl,
    this.targetUrl,
  );

  factory ProfileVillageInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$ProfileVillageInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProfileVillageInfoToJson(this);
}
