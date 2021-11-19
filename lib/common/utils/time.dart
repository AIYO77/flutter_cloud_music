///format milliseconds to time stamp like "06:23", which
///means 6 minute 23 seconds
String getTimeStamp(int milliseconds) {
  final int seconds = (milliseconds / 1000).truncate();
  final int minutes = (seconds / 60).truncate();

  final String minutesStr = (minutes % 60).toString().padLeft(2, '0');
  final String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  return "$minutesStr:$secondsStr";
}
