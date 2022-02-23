// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rcmd_song_daily_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RcmdSongDailyModel _$RcmdSongDailyModelFromJson(Map<String, dynamic> json) =>
    RcmdSongDailyModel(
      (json['dailySongs'] as List<dynamic>)
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['recommendReasons'] as List<dynamic>)
          .map((e) => RecommendReasons.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RcmdSongDailyModelToJson(RcmdSongDailyModel instance) =>
    <String, dynamic>{
      'dailySongs': instance.dailySongs,
      'recommendReasons': instance.recommendReasons,
    };

RecommendReasons _$RecommendReasonsFromJson(Map<String, dynamic> json) =>
    RecommendReasons(
      json['songId'] as int,
      json['reason'] as String,
    );

Map<String, dynamic> _$RecommendReasonsToJson(RecommendReasons instance) =>
    <String, dynamic>{
      'songId': instance.songId,
      'reason': instance.reason,
    };
