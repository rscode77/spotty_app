import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get getOnlyDate => '$year-${month < 10 ? '0$month' : month}-${day < 10 ? '0$day' : day} ';
  String get getOnlyTime => '${hour < 10 ? '0$hour' : hour}:${minute < 10 ? '0$minute' : minute}';
  String get getFullDate => '${DateFormat('dd-MMMM').format(this)} $getOnlyTime';
}