import 'package:json_annotation/json_annotation.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfo extends Object {
  @JsonKey(name: 'defaultAvatar')
  bool defaultAvatar;

  @JsonKey(name: 'province')
  int province;

  @JsonKey(name: 'authStatus')
  int authStatus;

  @JsonKey(name: 'followed')
  bool followed;

  @JsonKey(name: 'avatarUrl')
  String avatarUrl;

  @JsonKey(name: 'accountStatus')
  int accountStatus;

  @JsonKey(name: 'gender')
  int gender;

  @JsonKey(name: 'city')
  int city;

  @JsonKey(name: 'birthday')
  int birthday;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'userType')
  int userType;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'signature')
  String? signature;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'detailDescription')
  String? detailDescription;

  @JsonKey(name: 'avatarImgId')
  int avatarImgId;

  @JsonKey(name: 'backgroundImgId')
  int backgroundImgId;

  @JsonKey(name: 'backgroundUrl')
  String? backgroundUrl;

  @JsonKey(name: 'authority')
  int authority;

  @JsonKey(name: 'mutual')
  bool mutual;

  @JsonKey(name: 'djStatus')
  int djStatus;

  @JsonKey(name: 'vipType')
  int vipType;

  @JsonKey(name: 'remarkName')
  String? remarkName;

  @JsonKey(name: 'avatarImgIdStr')
  String avatarImgIdStr;

  @JsonKey(name: 'avatarDetail')
  AvatarDetail? avatarDetail;

  @JsonKey(name: 'backgroundImgIdStr')
  String backgroundImgIdStr;

  UserInfo(
    this.defaultAvatar,
    this.province,
    this.authStatus,
    this.followed,
    this.avatarUrl,
    this.accountStatus,
    this.gender,
    this.city,
    this.birthday,
    this.userId,
    this.userType,
    this.nickname,
    this.signature,
    this.description,
    this.detailDescription,
    this.avatarImgId,
    this.backgroundImgId,
    this.backgroundUrl,
    this.authority,
    this.mutual,
    this.djStatus,
    this.vipType,
    this.remarkName,
    this.avatarImgIdStr,
    this.avatarDetail,
    this.backgroundImgIdStr,
  );

  factory UserInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$UserInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class AvatarDetail extends Object {
  @JsonKey(name: 'userType')
  int userType;

  @JsonKey(name: 'identityLevel')
  int identityLevel;

  @JsonKey(name: 'identityIconUrl')
  String identityIconUrl;

  AvatarDetail(this.userType, this.identityIconUrl, this.identityLevel);

  factory AvatarDetail.fromJson(Map<String, dynamic> srcJson) =>
      _$AvatarDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AvatarDetailToJson(this);
}
