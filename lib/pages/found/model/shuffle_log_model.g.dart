// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shuffle_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShuffleLogModel _$ShuffleLogModelFromJson(Map<String, dynamic> json) =>
    ShuffleLogModel(
      json['id'] as String,
      json['type'] as int,
      json['mlogBaseDataType'] as int,
      json['sameCity'] as bool,
      MLogResource.fromJson(json['resource'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShuffleLogModelToJson(ShuffleLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'mlogBaseDataType': instance.mlogBaseDataType,
      'sameCity': instance.sameCity,
      'resource': instance.resource,
    };

MLogResource _$MLogResourceFromJson(Map<String, dynamic> json) => MLogResource(
      MlogBaseData.fromJson(json['mlogBaseData'] as Map<String, dynamic>),
      MlogExtVO.fromJson(json['mlogExtVO'] as Map<String, dynamic>),
      json['shareUrl'] as String,
      json['userProfile'] == null
          ? null
          : VideoUserProfile.fromJson(
              json['userProfile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MLogResourceToJson(MLogResource instance) =>
    <String, dynamic>{
      'mlogBaseData': instance.mlogBaseData,
      'mlogExtVO': instance.mlogExtVO,
      'shareUrl': instance.shareUrl,
      'userProfile': instance.userProfile,
    };

MlogBaseData _$MlogBaseDataFromJson(Map<String, dynamic> json) => MlogBaseData(
      json['id'] as String,
      json['type'] as int,
      json['text'] as String,
      json['desc'] as String?,
      json['coverUrl'] as String,
      json['duration'] as int,
      json['pubTime'] as int,
    );

Map<String, dynamic> _$MlogBaseDataToJson(MlogBaseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'text': instance.text,
      'desc': instance.desc,
      'coverUrl': instance.coverUrl,
      'duration': instance.duration,
      'pubTime': instance.pubTime,
    };

MlogExtVO _$MlogExtVOFromJson(Map<String, dynamic> json) => MlogExtVO(
      json['likedCount'] as int,
      json['commentCount'] as int,
      json['playCount'] as int?,
      json['canCollect'] as bool,
      json['song'] == null
          ? null
          : VideoSong.fromJson(json['song'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MlogExtVOToJson(MlogExtVO instance) => <String, dynamic>{
      'likedCount': instance.likedCount,
      'commentCount': instance.commentCount,
      'playCount': instance.playCount,
      'canCollect': instance.canCollect,
      'song': instance.song,
    };

VideoSong _$VideoSongFromJson(Map<String, dynamic> json) => VideoSong(
      json['id'] as int,
      json['name'] as String,
      (json['artists'] as List<dynamic>)
          .map((e) => VideoSongArtists.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['albumName'] as String,
    );

Map<String, dynamic> _$VideoSongToJson(VideoSong instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'artists': instance.artists,
      'albumName': instance.albumName,
    };

VideoSongArtists _$VideoSongArtistsFromJson(Map<String, dynamic> json) =>
    VideoSongArtists(
      json['artistId'] as int,
      json['artistName'] as String,
    );

Map<String, dynamic> _$VideoSongArtistsToJson(VideoSongArtists instance) =>
    <String, dynamic>{
      'artistId': instance.artistId,
      'artistName': instance.artistName,
    };

VideoUserProfile _$VideoUserProfileFromJson(Map<String, dynamic> json) =>
    VideoUserProfile(
      json['userId'] as int,
      json['nickname'] as String,
      json['avatarUrl'] as String,
      json['followed'] as bool,
    );

Map<String, dynamic> _$VideoUserProfileToJson(VideoUserProfile instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'followed': instance.followed,
    };
