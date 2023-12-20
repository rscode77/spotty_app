extension IntExtensions on int {
  bool get isGreaterThanZero => this > 0;
  bool get isZero => this == 0;
}

extension NullableIntExtensions on int? {
  int orZero() => this ?? 0;

  bool isNotNullAndGreaterThanZero() => orZero() > 0;

  String toStringOrEmpty() => this != null ? toString() : '';
}
