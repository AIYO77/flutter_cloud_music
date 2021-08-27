import 'package:json_annotation/json_annotation.dart';

part 'found_music_calendar_model.g.dart';

@JsonSerializable()
class FoundMusicCalendarModel extends Object {
  @JsonKey(name: 'startTime')
  int startTime;

  @JsonKey(name: 'endTime')
  int endTime;

  @JsonKey(name: 'subed')
  bool subed;

  @JsonKey(name: 'subCount')
  int? subCount;

  @JsonKey(name: 'canSubscribe')
  bool canSubscribe;

  @JsonKey(name: 'tags')
  List<String>? tags;

  FoundMusicCalendarModel(
    this.startTime,
    this.endTime,
    this.subed,
    this.subCount,
    this.canSubscribe,
    this.tags,
  );

  factory FoundMusicCalendarModel.fromJson(Map<String, dynamic> srcJson) =>
      _$FoundMusicCalendarModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FoundMusicCalendarModelToJson(this);
}
