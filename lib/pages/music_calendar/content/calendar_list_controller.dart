import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/pages/music_calendar/content/calender_model.dart';
import 'package:get/get.dart';

class CalendarListController extends GetxController {
  final DateTime dateTime;

  CalendarListController(this.dateTime);

  final data = Rx<List<CalenderModel>?>(null);

  int initialScrollIndex = 0;

  int? showFollowDay;

  @override
  void onReady() {
    super.onReady();
    final startTime = DateTime(dateTime.year, dateTime.month);
    // final countDay = DateTime(dateTime.year, dateTime.month + 1, 0).day;
    final countDay = DateUtils.getDaysInMonth(dateTime.year, dateTime.month);
    final endTime = DateTime(dateTime.year, dateTime.month, countDay);
    requestList(startTime, endTime);
  }

  void requestList(DateTime startTime, DateTime endTime) {
    MusicApi.getCalendarEvents(startTime, endTime).then((value) {
      final scrollIndex = value
          .indexWhere((element) => DateUtils.isSameDay(dateTime, element.time));
      if (scrollIndex != -1) {
        initialScrollIndex = scrollIndex;
      }
      data.value = value;
    });
  }
}
