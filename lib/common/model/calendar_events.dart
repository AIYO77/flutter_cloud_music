import 'package:json_annotation/json_annotation.dart';

part 'calendar_events.g.dart';

@JsonSerializable()
class CalendarEvents extends Object {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'eventType')
  String eventType;

  @JsonKey(name: 'onlineTime')
  int onlineTime;

  @JsonKey(name: 'offlineTime')
  int offlineTime;

  @JsonKey(name: 'tag')
  String tag;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'imgUrl')
  String imgUrl;

  @JsonKey(name: 'canRemind')
  bool canRemind;

  @JsonKey(name: 'reminded')
  bool reminded;

  @JsonKey(name: 'targetUrl')
  String targetUrl;

  @JsonKey(name: 'remindText')
  String remindText;

  @JsonKey(name: 'resourceType')
  String resourceType;

  @JsonKey(name: 'resourceId')
  String resourceId;

  @JsonKey(name: 'eventStatus')
  String eventStatus;

  @JsonKey(name: 'remindedText')
  String remindedText;

  @JsonKey(name: 'headline')
  bool headline;

  @JsonKey(name: 'subCount')
  int subCount;

  CalendarEvents(
    this.id,
    this.eventType,
    this.onlineTime,
    this.offlineTime,
    this.tag,
    this.title,
    this.imgUrl,
    this.canRemind,
    this.reminded,
    this.targetUrl,
    this.remindText,
    this.resourceType,
    this.resourceId,
    this.eventStatus,
    this.remindedText,
    this.headline,
    this.subCount,
  );

  factory CalendarEvents.fromJson(Map<String, dynamic> srcJson) =>
      _$CalendarEventsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CalendarEventsToJson(this);
}
