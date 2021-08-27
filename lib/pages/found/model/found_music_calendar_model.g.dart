// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'found_music_calendar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoundMusicCalendarModel _$FoundMusicCalendarModelFromJson(
        Map<String, dynamic> json) =>
    FoundMusicCalendarModel(
      json['startTime'] as int,
      json['endTime'] as int,
      json['subed'] as bool,
      json['subCount'] as int?,
      json['canSubscribe'] as bool,
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FoundMusicCalendarModelToJson(
        FoundMusicCalendarModel instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'subed': instance.subed,
      'subCount': instance.subCount,
      'canSubscribe': instance.canSubscribe,
      'tags': instance.tags,
    };
