// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankItemModel _$RankItemModelFromJson(Map<String, dynamic> json) =>
    RankItemModel(
      (json['tracks'] as List<dynamic>)
          .map((e) => RankTracks.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['updateFrequency'] as String,
      json['userId'] as int,
      json['subscribedCount'] as int,
      json['coverImgUrl'] as String,
      json['playCount'] as int,
      json['name'] as String,
      json['id'] as int,
      json['updateTime'] as int,
    );

Map<String, dynamic> _$RankItemModelToJson(RankItemModel instance) =>
    <String, dynamic>{
      'tracks': instance.tracks,
      'updateFrequency': instance.updateFrequency,
      'userId': instance.userId,
      'subscribedCount': instance.subscribedCount,
      'coverImgUrl': instance.coverImgUrl,
      'playCount': instance.playCount,
      'name': instance.name,
      'id': instance.id,
      'updateTime': instance.updateTime,
    };

RankTracks _$RankTracksFromJson(Map<String, dynamic> json) => RankTracks(
      json['first'] as String,
      json['second'] as String,
    );

Map<String, dynamic> _$RankTracksToJson(RankTracks instance) =>
    <String, dynamic>{
      'first': instance.first,
      'second': instance.second,
    };
