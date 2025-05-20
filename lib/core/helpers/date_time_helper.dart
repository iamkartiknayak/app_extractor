import 'package:intl/intl.dart';

class DatetimeHelper {
  static String formatEpochTime(final int installTimeMillis) {
    final d = DateTime.fromMillisecondsSinceEpoch(installTimeMillis);
    final sfx =
        (d.day >= 11 && d.day <= 13)
            ? 'th'
            : {1: 'st', 2: 'nd', 3: 'rd'}[d.day % 10] ?? 'th';
    final monthName = DateFormat('MMM').format(d);
    return '${d.day}$sfx $monthName ${d.year}';
  }
}
