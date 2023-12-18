extension DateTimeExtension on DateTime {
  String get getOnlyDate => '$year-$month-${day < 10 ? '0$day' : day} ';
}