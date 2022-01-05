// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEvents _$CalendarEventsFromJson(Map<String, dynamic> json) =>
    CalendarEvents(
      json['id'] as String,
      json['eventType'] as String,
      json['onlineTime'] as int,
      json['offlineTime'] as int,
      json['tag'] as String,
      json['title'] as String,
      json['imgUrl'] as String,
      json['canRemind'] as bool,
      json['reminded'] as bool,
      json['targetUrl'] as String,
      json['remindText'] as String,
      json['resourceType'] as String,
      json['resourceId'] as String,
      json['eventStatus'] as String,
      json['remindedText'] as String,
      json['headline'] as bool,
      json['subCount'] as int,
    );

Map<String, dynamic> _$CalendarEventsToJson(CalendarEvents instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventType': instance.eventType,
      'onlineTime': instance.onlineTime,
      'offlineTime': instance.offlineTime,
      'tag': instance.tag,
      'title': instance.title,
      'imgUrl': instance.imgUrl,
      'canRemind': instance.canRemind,
      'reminded': instance.reminded,
      'targetUrl': instance.targetUrl,
      'remindText': instance.remindText,
      'resourceType': instance.resourceType,
      'resourceId': instance.resourceId,
      'eventStatus': instance.eventStatus,
      'remindedText': instance.remindedText,
      'headline': instance.headline,
      'subCount': instance.subCount,
    };
