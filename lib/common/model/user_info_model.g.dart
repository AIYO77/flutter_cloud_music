// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      json['defaultAvatar'] as bool,
      json['province'] as int,
      json['authStatus'] as int,
      json['followed'] as bool,
      json['avatarUrl'] as String,
      json['accountStatus'] as int,
      json['gender'] as int,
      json['city'] as int,
      json['birthday'] as int,
      json['userId'] as int,
      json['userType'] as int,
      json['nickname'] as String,
      json['signature'] as String?,
      json['description'] as String?,
      json['detailDescription'] as String?,
      json['avatarImgId'] as int,
      json['backgroundImgId'] as int,
      json['backgroundUrl'] as String?,
      json['authority'] as int,
      json['mutual'] as bool,
      json['djStatus'] as int,
      json['vipType'] as int,
      json['remarkName'] as String?,
      json['avatarDetail'] == null
          ? null
          : AvatarDetail.fromJson(json['avatarDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'defaultAvatar': instance.defaultAvatar,
      'province': instance.province,
      'authStatus': instance.authStatus,
      'followed': instance.followed,
      'avatarUrl': instance.avatarUrl,
      'accountStatus': instance.accountStatus,
      'gender': instance.gender,
      'city': instance.city,
      'birthday': instance.birthday,
      'userId': instance.userId,
      'userType': instance.userType,
      'nickname': instance.nickname,
      'signature': instance.signature,
      'description': instance.description,
      'detailDescription': instance.detailDescription,
      'avatarImgId': instance.avatarImgId,
      'backgroundImgId': instance.backgroundImgId,
      'backgroundUrl': instance.backgroundUrl,
      'authority': instance.authority,
      'mutual': instance.mutual,
      'djStatus': instance.djStatus,
      'vipType': instance.vipType,
      'remarkName': instance.remarkName,
      'avatarDetail': instance.avatarDetail,
    };

AvatarDetail _$AvatarDetailFromJson(Map<String, dynamic> json) => AvatarDetail(
      json['userType'] as int,
      json['identityIconUrl'] as String,
      json['identityLevel'] as int,
    );

Map<String, dynamic> _$AvatarDetailToJson(AvatarDetail instance) =>
    <String, dynamic>{
      'userType': instance.userType,
      'identityLevel': instance.identityLevel,
      'identityIconUrl': instance.identityIconUrl,
    };
