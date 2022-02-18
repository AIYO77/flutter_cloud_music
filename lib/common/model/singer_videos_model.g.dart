// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'singer_videos_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingerVideosModel _$SingerVideosModelFromJson(Map<String, dynamic> json) =>
    SingerVideosModel(
      (json['records'] as List<dynamic>)
          .map((e) => Records.fromJson(e as Map<String, dynamic>))
          .toList(),
      Page.fromJson(json['page'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingerVideosModelToJson(SingerVideosModel instance) =>
    <String, dynamic>{
      'records': instance.records,
      'page': instance.page,
    };

Records _$RecordsFromJson(Map<String, dynamic> json) => Records(
      json['id'] as String,
      json['type'] as int,
      Resource.fromJson(json['resource'] as Map<String, dynamic>),
      json['sameCity'] as bool,
    );

Map<String, dynamic> _$RecordsToJson(Records instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'resource': instance.resource,
      'sameCity': instance.sameCity,
    };

Resource _$ResourceFromJson(Map<String, dynamic> json) => Resource(
      MlogBaseData.fromJson(json['mlogBaseData'] as Map<String, dynamic>),
      MlogExtVO.fromJson(json['mlogExtVO'] as Map<String, dynamic>),
      json['status'] as int,
      json['shareUrl'] as String,
    );

Map<String, dynamic> _$ResourceToJson(Resource instance) => <String, dynamic>{
      'mlogBaseData': instance.mlogBaseData,
      'mlogExtVO': instance.mlogExtVO,
      'status': instance.status,
      'shareUrl': instance.shareUrl,
    };

MlogBaseData _$MlogBaseDataFromJson(Map<String, dynamic> json) => MlogBaseData(
      json['id'] as String,
      json['type'] as int,
      json['text'] as String,
      json['desc'] as String,
      json['pubTime'] as int,
      json['coverUrl'] as String,
      json['greatCover'] as bool,
      json['coverHeight'] as int,
      json['coverWidth'] as int,
      json['coverColor'] as int,
      json['duration'] as int,
    );

Map<String, dynamic> _$MlogBaseDataToJson(MlogBaseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'text': instance.text,
      'desc': instance.desc,
      'pubTime': instance.pubTime,
      'coverUrl': instance.coverUrl,
      'greatCover': instance.greatCover,
      'coverHeight': instance.coverHeight,
      'coverWidth': instance.coverWidth,
      'coverColor': instance.coverColor,
      'duration': instance.duration,
    };

MlogExtVO _$MlogExtVOFromJson(Map<String, dynamic> json) => MlogExtVO(
      json['likedCount'] as int,
      json['commentCount'] as int,
      json['playCount'] as int,
      json['shareCount'] as int,
      json['canCollect'] as bool,
      json['artistName'] as String,
      (json['artists'] as List<dynamic>)
          .map((e) => VideoArtists.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MlogExtVOToJson(MlogExtVO instance) => <String, dynamic>{
      'likedCount': instance.likedCount,
      'commentCount': instance.commentCount,
      'playCount': instance.playCount,
      'shareCount': instance.shareCount,
      'canCollect': instance.canCollect,
      'artistName': instance.artistName,
      'artists': instance.artists,
    };

VideoArtists _$VideoArtistsFromJson(Map<String, dynamic> json) => VideoArtists(
      json['id'] as int,
      json['name'] as String,
      json['img1v1Url'] as String,
      json['followed'] as bool,
    );

Map<String, dynamic> _$VideoArtistsToJson(VideoArtists instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'img1v1Url': instance.img1v1Url,
      'followed': instance.followed,
    };

Page _$PageFromJson(Map<String, dynamic> json) => Page(
      json['size'] as int,
      json['cursor'] as String,
      json['more'] as bool,
    );

Map<String, dynamic> _$PageToJson(Page instance) => <String, dynamic>{
      'size': instance.size,
      'cursor': instance.cursor,
      'more': instance.more,
    };
