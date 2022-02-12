// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailModel _$UserDetailModelFromJson(Map<String, dynamic> json) =>
    UserDetailModel(
      json['identify'] == null
          ? null
          : Identify.fromJson(json['identify'] as Map<String, dynamic>),
      json['level'] as int,
      json['listenSongs'] as int,
      Profile.fromJson(json['profile'] as Map<String, dynamic>),
      json['createTime'] as int,
      json['createDays'] as int,
      json['profileVillageInfo'] == null
          ? null
          : ProfileVillageInfo.fromJson(
              json['profileVillageInfo'] as Map<String, dynamic>),
    )..singerModel = json['singerModel'] == null
        ? null
        : SingerDetailModel.fromJson(
            json['singerModel'] as Map<String, dynamic>);

Map<String, dynamic> _$UserDetailModelToJson(UserDetailModel instance) =>
    <String, dynamic>{
      'identify': instance.identify,
      'level': instance.level,
      'listenSongs': instance.listenSongs,
      'profile': instance.profile,
      'createTime': instance.createTime,
      'createDays': instance.createDays,
      'profileVillageInfo': instance.profileVillageInfo,
      'singerModel': instance.singerModel,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      json['userType'] as int,
      json['authStatus'] as int,
      json['description'] as String,
      json['userId'] as int,
      json['birthday'] as int,
      json['gender'] as int,
      json['nickname'] as String,
      json['avatarUrl'] as String,
      json['backgroundUrl'] as String,
      json['city'] as int,
      json['followed'] as bool,
      json['signature'] as String,
      json['followeds'] as int,
      json['follows'] as int,
      json['eventCount'] as int,
      json['followMe'] as bool,
      json['playlistCount'] as int,
      json['artistId'] as int?,
      json['artistName'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'userType': instance.userType,
      'authStatus': instance.authStatus,
      'description': instance.description,
      'userId': instance.userId,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'backgroundUrl': instance.backgroundUrl,
      'city': instance.city,
      'followed': instance.followed,
      'signature': instance.signature,
      'followeds': instance.followeds,
      'follows': instance.follows,
      'eventCount': instance.eventCount,
      'followMe': instance.followMe,
      'playlistCount': instance.playlistCount,
      'artistId': instance.artistId,
      'artistName': instance.artistName,
    };

ProfileVillageInfo _$ProfileVillageInfoFromJson(Map<String, dynamic> json) =>
    ProfileVillageInfo(
      json['title'] as String,
      json['imageUrl'] as String,
      json['targetUrl'] as String?,
    );

Map<String, dynamic> _$ProfileVillageInfoToJson(ProfileVillageInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'targetUrl': instance.targetUrl,
    };
