import 'package:flutter_cloud_music/common/model/calendar_events.dart';

class CalenderModel {
  final DateTime time;
  final List<CalendarEvents> events;
  bool pickUp; //是否收起 默认收起

  CalenderModel(this.time, this.events, {this.pickUp = true});

  bool showPicUp() {
    return pickUp && events.length > 3;
  }
}
