import 'package:timeago/timeago.dart' as timeago;

class MyCustomEnMessages implements timeago.LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'now';
  @override
  String aboutAMinute(int minutes) => '${minutes}m';
  @override
  String minutes(int minutes) => '${minutes}m';
  @override
  String aboutAnHour(int minutes) => '${minutes}m';
  @override
  String hours(int hours) => '${hours}h';
  @override
  String aDay(int hours) => '${hours}h';
  @override
  String days(int days) => '${days}d';
  @override
  String aboutAMonth(int days) => '${days}d';
  @override
  String months(int months) => '${months}mo';
  @override
  String aboutAYear(int year) => '${year}y';
  @override
  String years(int years) => '${years}y';
  @override
  String wordSeparator() => ' ';
}

class MyCustomArMessages implements timeago.LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'الآن';
  @override
  String aboutAMinute(int minutes) => '$minutes دقيقة';
  @override
  String minutes(int minutes) => '$minutes دقيقة';
  @override
  String aboutAnHour(int minutes) => '$minutes دقيقة';
  @override
  String hours(int hours) => '$hours ساعة';
  @override
  String aDay(int hours) => '$hours ساعة';
  @override
  String days(int days) => '$days يوم';
  @override
  String aboutAMonth(int days) => '$days يوم';
  @override
  String months(int months) => '$months شهر';
  @override
  String aboutAYear(int year) => '$year شهر';
  @override
  String years(int years) => '$years سنة';
  @override
  String wordSeparator() => ' ';
}
