import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///format milliseconds to time stamp like "06:23", which
///means 6 minute 23 seconds
String getTimeStamp(int milliseconds) {
  final int seconds = (milliseconds / 1000).truncate();
  final int minutes = (seconds / 60).truncate();

  final String minutesStr = (minutes % 60).toString().padLeft(2, '0');
  final String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  return "$minutesStr:$secondsStr";
}

String millFormat(int mill, {String format = 'yyyy-MM-dd'}) {
  try {
    final date = DateTime.fromMillisecondsSinceEpoch(mill);
    final formatDate = DateFormat(format);
    return formatDate.format(date);
  } catch (e) {
    return '';
  }
}

String getCommentTimeStr(int timeMill) {
  final commentTime = DateTime.fromMillisecondsSinceEpoch(timeMill);
  String time = DateFormat('yyyy-MM-dd').format(commentTime);
  final nowTime = DateTime.now();
  final isSameDay = DateUtils.isSameDay(commentTime, nowTime);
  if (isSameDay) {
    time = DateFormat('HH:mm').format(commentTime);
  } else {
    final yesterday = isYesterday(commentTime, nowTime);
    if (yesterday) {
      time = '昨天${DateFormat('HH:mm').format(commentTime)}';
    } else {
      if (commentTime.year == nowTime.year) {
        final diffDay = getDayOfYear(nowTime) - getDayOfYear(commentTime);
        if (diffDay <= 7) {
          time = '$diffDay天前';
        } else {
          time = DateFormat('MM-dd').format(commentTime);
        }
      }
    }
  }
  if (commentTime.year == nowTime.year) {}
  return time;
}

/// get day of year.
/// 在今年的第几天.
int getDayOfYear(DateTime dateTime) {
  final year = dateTime.year;
  final month = dateTime.month;
  int days = dateTime.day;
  for (int i = 1; i < month; i++) {
    days = days + MONTH_DAY[i]!;
  }
  if (isLeapYearByYear(year) && month > 2) {
    days = days + 1;
  }
  return days;
}

/// Return whether it is leap year.
/// 是否是闰年
bool isLeapYearByYear(int year) {
  return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
}

/// is yesterday by dateTime.
/// 根据时间判断是否是昨天
bool isYesterday(DateTime dateTime, DateTime locDateTime) {
  if (yearIsEqual(dateTime, locDateTime)) {
    final spDay = getDayOfYear(locDateTime) - getDayOfYear(dateTime);
    return spDay == 1;
  } else {
    return (locDateTime.year - dateTime.year == 1) &&
        dateTime.month == 12 &&
        locDateTime.month == 1 &&
        dateTime.day == 31 &&
        locDateTime.day == 1;
  }
}

/// year is equal.
/// 是否同年.
bool yearIsEqual(DateTime dateTime, DateTime locDateTime) {
  return dateTime.year == locDateTime.year;
}

/// month->days.
Map<int, int> MONTH_DAY = {
  1: 31,
  2: 28,
  3: 31,
  4: 30,
  5: 31,
  6: 30,
  7: 31,
  8: 31,
  9: 30,
  10: 31,
  11: 30,
  12: 31,
};
