import 'package:flutter_cloud_music/common/model/user_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends Object {
  @JsonKey(name: 'loginType')
  int loginType;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'account')
  Account account;

  @JsonKey(name: 'token')
  String token;

  @JsonKey(name: 'profile')
  Profile? profile;

  @JsonKey(name: 'cookie')
  String cookie;

  LoginResponse(
    this.loginType,
    this.code,
    this.account,
    this.token,
    this.profile,
    this.cookie,
  );

  factory LoginResponse.fromJson(Map<String, dynamic> srcJson) =>
      _$LoginResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'loginType': loginType,
        'code': code,
        'account': account.toJson(),
        'token': token,
        'profile': profile?.toJson(),
        'cookie': cookie,
      };
}

@JsonSerializable()
class Account extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'userName')
  String userName;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'whitelistAuthority')
  int whitelistAuthority;

  @JsonKey(name: 'createTime')
  int createTime;

  @JsonKey(name: 'salt')
  String salt;

  @JsonKey(name: 'tokenVersion')
  int tokenVersion;

  @JsonKey(name: 'ban')
  int ban;

  @JsonKey(name: 'baoyueVersion')
  int baoyueVersion;

  @JsonKey(name: 'donateVersion')
  int donateVersion;

  @JsonKey(name: 'vipType')
  int vipType;

  @JsonKey(name: 'viptypeVersion')
  int viptypeVersion;

  @JsonKey(name: 'anonimousUser')
  bool anonimousUser;

  Account(
    this.id,
    this.userName,
    this.type,
    this.status,
    this.whitelistAuthority,
    this.createTime,
    this.salt,
    this.tokenVersion,
    this.ban,
    this.baoyueVersion,
    this.donateVersion,
    this.vipType,
    this.viptypeVersion,
    this.anonimousUser,
  );

  factory Account.fromJson(Map<String, dynamic> srcJson) =>
      _$AccountFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable()
class Profile extends Object {
  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'userType')
  int userType;

  @JsonKey(name: 'city')
  int city;

  @JsonKey(name: 'avatarUrl')
  String avatarUrl;

  @JsonKey(name: 'djStatus')
  int djStatus;

  @JsonKey(name: 'followed')
  bool followed;

  @JsonKey(name: 'backgroundUrl')
  String backgroundUrl;

  @JsonKey(name: 'detailDescription')
  String detailDescription;

  @JsonKey(name: 'avatarImgIdStr')
  String avatarImgIdStr;

  @JsonKey(name: 'backgroundImgIdStr')
  String backgroundImgIdStr;

  @JsonKey(name: 'vipType')
  int vipType;

  @JsonKey(name: 'avatarImgId')
  int avatarImgId;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'accountStatus')
  int accountStatus;

  @JsonKey(name: 'gender')
  int gender;

  @JsonKey(name: 'backgroundImgId')
  int backgroundImgId;

  @JsonKey(name: 'birthday')
  int birthday;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'mutual')
  bool mutual;

  @JsonKey(name: 'authStatus')
  int authStatus;

  @JsonKey(name: 'defaultAvatar')
  bool defaultAvatar;

  @JsonKey(name: 'province')
  int province;

  @JsonKey(name: 'signature')
  String signature;

  @JsonKey(name: 'authority')
  int authority;

  @JsonKey(name: 'followeds')
  int followeds;

  @JsonKey(name: 'follows')
  int follows;

  @JsonKey(name: 'eventCount')
  int eventCount;

  @JsonKey(name: 'playlistCount')
  int playlistCount;

  @JsonKey(name: 'playlistBeSubscribedCount')
  int playlistBeSubscribedCount;

  Profile(
    this.userId,
    this.userType,
    this.city,
    this.avatarUrl,
    this.djStatus,
    this.followed,
    this.backgroundUrl,
    this.detailDescription,
    this.avatarImgIdStr,
    this.backgroundImgIdStr,
    this.vipType,
    this.avatarImgId,
    this.nickname,
    this.accountStatus,
    this.gender,
    this.backgroundImgId,
    this.birthday,
    this.description,
    this.mutual,
    this.authStatus,
    this.defaultAvatar,
    this.province,
    this.signature,
    this.authority,
    this.followeds,
    this.follows,
    this.eventCount,
    this.playlistCount,
    this.playlistBeSubscribedCount,
  );

  factory Profile.fromJson(Map<String, dynamic> srcJson) =>
      _$ProfileFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class Experts extends Object {
  Experts();

  factory Experts.fromJson(Map<String, dynamic> srcJson) =>
      _$ExpertsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ExpertsToJson(this);
}

extension ProfileToUserInfoExt on Profile {
  UserInfo userinfo() {
    return UserInfo(followed, avatarUrl, gender, birthday, userId, nickname,
        signature, description, detailDescription, backgroundUrl, null, null);
  }
}
