import 'package:intl/intl.dart';

class TimeFormat {
  static String songDuration(Duration? duration) {
    if (duration == null) {
      return "00:00";
    }
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  static String date(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return DateFormat("yy-MM-dd").format(dateTime);
  }
}
