// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mine_playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinePlaylist _$MinePlaylistFromJson(Map<String, dynamic> json) => MinePlaylist(
      json['trackCount'] as int,
      json['specialType'] as int,
      json['name'] as String,
      json['coverImgUrl'] as String,
      json['id'] as int,
      UserInfo.fromJson(json['creator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MinePlaylistToJson(MinePlaylist instance) =>
    <String, dynamic>{
      'trackCount': instance.trackCount,
      'specialType': instance.specialType,
      'name': instance.name,
      'coverImgUrl': instance.coverImgUrl,
      'id': instance.id,
      'creator': instance.creator,
    };
