import 'package:intl/intl.dart';

extension IntExtensions on int {
  bool get isGreaterThanZero => this > 0;
  bool get isZero => this == 0;
}

extension NullableIntExtensions on int? {
  int orZero() => this ?? 0;

  bool isNotNullAndGreaterThanZero() => orZero() > 0;

  String toStringOrEmpty() => this != null ? toString() : '';
}

extension TimestampExtensions on int {
  String toChatTime() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(this);
    if (date.day < 1) {
      return DateFormat('dd-MMM').format(date);
    } else {
      return DateFormat('HH:mm').format(date);
    }
  }
}