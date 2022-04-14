// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mv_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MvDetailModel _$MvDetailModelFromJson(Map<String, dynamic> json) =>
    MvDetailModel(
      json['id'] as int,
      json['name'] as String,
      json['artistId'] as int,
      json['artistName'] as String,
      json['briefDesc'] as String,
      json['desc'] as String?,
      json['cover'] as String,
      json['playCount'] as int,
      json['subCount'] as int,
      json['shareCount'] as int,
      json['commentCount'] as int,
      json['duration'] as int,
      (json['artists'] as List<dynamic>)
          .map((e) => MvArtists.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['alias'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['commentThreadId'] as String,
    );

Map<String, dynamic> _$MvDetailModelToJson(MvDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'artistId': instance.artistId,
      'artistName': instance.artistName,
      'briefDesc': instance.briefDesc,
      'desc': instance.desc,
      'cover': instance.cover,
      'playCount': instance.playCount,
      'subCount': instance.subCount,
      'shareCount': instance.shareCount,
      'commentCount': instance.commentCount,
      'duration': instance.duration,
      'artists': instance.artists,
      'alias': instance.alias,
      'commentThreadId': instance.commentThreadId,
    };

MvArtists _$MvArtistsFromJson(Map<String, dynamic> json) => MvArtists(
      json['id'] as int,
      json['name'] as String,
      json['followed'] as bool,
      json['img1v1Url'] as String?,
    );

Map<String, dynamic> _$MvArtistsToJson(MvArtists instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'followed': instance.followed,
      'img1v1Url': instance.img1v1Url,
    };
