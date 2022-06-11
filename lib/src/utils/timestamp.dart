import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String get date => _formatDate(toString());
  String get followUp => this.add(Duration(days: 10)).date;
  String get timestamp => millisecondsSinceEpoch.toString();
  String get dayStamp => _formatDay();

  String _formatDay() {
    DateTime now = DateTime.now().add(Duration(days: 3));
    final DateFormat customDate = DateFormat('E, MMM dd');
    final String formattedDate = customDate.format(now);
    return formattedDate;
  }

  String _formatDate(String date) {
    DateTime now = DateTime.parse(date);
    final DateFormat time = DateFormat('jm');
    final DateFormat customDate = DateFormat('MMM dd');
    final String formattedTime = time.format(now);
    final String formattedDate = customDate.format(now);
    return formattedDate + ", " + formattedTime;
  }

  bool isCallExpired() {
    var duration = DateTime.now().difference(this);
    return duration.inMilliseconds > 60000;
  }

  bool canFollowup() {
    var duration = DateTime.now().difference(this);
    return duration.inDays < 10;
  }
}

class DateConverter {
  static String getTimestamp({int? epochInt, String? epochString}) {
    var date = DateTime.fromMillisecondsSinceEpoch(
        (epochInt ?? int.parse(epochString!)));
    return date.toString();
  }

  static DateTime getDate({int? epochInt, String? epochString}) {
    return DateTime.fromMillisecondsSinceEpoch(
        (epochInt ?? int.parse(epochString!)));
  }

  static String formatted({int? epochInt, String? epochString}) {
    return DateTime.fromMillisecondsSinceEpoch(
            (epochInt ?? int.parse(epochString!)))
        .date;
  }
}
