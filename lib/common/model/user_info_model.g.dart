// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      json['followed'] as bool,
      json['avatarUrl'] as String,
      json['gender'] as int,
      json['birthday'] as int,
      json['userId'] as int,
      json['nickname'] as String,
      json['signature'] as String?,
      json['description'] as String?,
      json['detailDescription'] as String?,
      json['backgroundUrl'] as String?,
      json['remarkName'] as String?,
      json['avatarDetail'] == null
          ? null
          : AvatarDetail.fromJson(json['avatarDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'followed': instance.followed,
      'avatarUrl': instance.avatarUrl,
      'gender': instance.gender,
      'birthday': instance.birthday,
      'userId': instance.userId,
      'nickname': instance.nickname,
      'signature': instance.signature,
      'description': instance.description,
      'detailDescription': instance.detailDescription,
      'backgroundUrl': instance.backgroundUrl,
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
