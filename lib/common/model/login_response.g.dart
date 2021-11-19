// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['loginType'] as int,
      json['code'] as int,
      Account.fromJson(json['account'] as Map<String, dynamic>),
      json['token'] as String,
      Profile.fromJson(json['profile'] as Map<String, dynamic>),
      json['cookie'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'loginType': instance.loginType,
      'code': instance.code,
      'account': instance.account,
      'token': instance.token,
      'profile': instance.profile,
      'cookie': instance.cookie,
    };

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      json['id'] as int,
      json['userName'] as String,
      json['type'] as int,
      json['status'] as int,
      json['whitelistAuthority'] as int,
      json['createTime'] as int,
      json['salt'] as String,
      json['tokenVersion'] as int,
      json['ban'] as int,
      json['baoyueVersion'] as int,
      json['donateVersion'] as int,
      json['vipType'] as int,
      json['viptypeVersion'] as int,
      json['anonimousUser'] as bool,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'type': instance.type,
      'status': instance.status,
      'whitelistAuthority': instance.whitelistAuthority,
      'createTime': instance.createTime,
      'salt': instance.salt,
      'tokenVersion': instance.tokenVersion,
      'ban': instance.ban,
      'baoyueVersion': instance.baoyueVersion,
      'donateVersion': instance.donateVersion,
      'vipType': instance.vipType,
      'viptypeVersion': instance.viptypeVersion,
      'anonimousUser': instance.anonimousUser,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      json['userId'] as int,
      json['userType'] as int,
      json['city'] as int,
      json['avatarUrl'] as String,
      json['djStatus'] as int,
      json['followed'] as bool,
      json['backgroundUrl'] as String,
      json['detailDescription'] as String,
      json['avatarImgIdStr'] as String,
      json['backgroundImgIdStr'] as String,
      json['vipType'] as int,
      json['avatarImgId'] as int,
      json['nickname'] as String,
      json['accountStatus'] as int,
      json['gender'] as int,
      json['backgroundImgId'] as int,
      json['birthday'] as int,
      json['description'] as String,
      json['mutual'] as bool,
      json['authStatus'] as int,
      json['defaultAvatar'] as bool,
      json['province'] as int,
      json['signature'] as String,
      json['authority'] as int,
      json['followeds'] as int,
      json['follows'] as int,
      json['eventCount'] as int,
      json['playlistCount'] as int,
      json['playlistBeSubscribedCount'] as int,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'userId': instance.userId,
      'userType': instance.userType,
      'city': instance.city,
      'avatarUrl': instance.avatarUrl,
      'djStatus': instance.djStatus,
      'followed': instance.followed,
      'backgroundUrl': instance.backgroundUrl,
      'detailDescription': instance.detailDescription,
      'avatarImgIdStr': instance.avatarImgIdStr,
      'backgroundImgIdStr': instance.backgroundImgIdStr,
      'vipType': instance.vipType,
      'avatarImgId': instance.avatarImgId,
      'nickname': instance.nickname,
      'accountStatus': instance.accountStatus,
      'gender': instance.gender,
      'backgroundImgId': instance.backgroundImgId,
      'birthday': instance.birthday,
      'description': instance.description,
      'mutual': instance.mutual,
      'authStatus': instance.authStatus,
      'defaultAvatar': instance.defaultAvatar,
      'province': instance.province,
      'signature': instance.signature,
      'authority': instance.authority,
      'followeds': instance.followeds,
      'follows': instance.follows,
      'eventCount': instance.eventCount,
      'playlistCount': instance.playlistCount,
      'playlistBeSubscribedCount': instance.playlistBeSubscribedCount,
    };

Experts _$ExpertsFromJson(Map<String, dynamic> json) => Experts();

Map<String, dynamic> _$ExpertsToJson(Experts instance) => <String, dynamic>{};
