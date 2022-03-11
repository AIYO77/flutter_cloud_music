import 'package:json_annotation/json_annotation.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfo extends Object {
  @JsonKey(name: 'followed')
  bool followed;

  @JsonKey(name: 'avatarUrl')
  String avatarUrl;

  @JsonKey(name: 'gender')
  int gender;

  @JsonKey(name: 'birthday')
  int birthday;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'signature')
  String? signature;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'detailDescription')
  String? detailDescription;

  @JsonKey(name: 'backgroundUrl')
  String? backgroundUrl;

  @JsonKey(name: 'remarkName')
  String? remarkName;

  @JsonKey(name: 'avatarDetail')
  AvatarDetail? avatarDetail;

  UserInfo(
    this.followed,
    this.avatarUrl,
    this.gender,
    this.birthday,
    this.userId,
    this.nickname,
    this.signature,
    this.description,
    this.detailDescription,
    this.backgroundUrl,
    this.remarkName,
    this.avatarDetail,
  );

  factory UserInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$UserInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  String getGenderStr() {
    return gender == 2
        ? '女'
        : gender == 1
            ? '男'
            : '';
  }
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
