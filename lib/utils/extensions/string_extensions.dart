extension StringExtensions on String {
  bool get isBlank => trim().isEmpty;

  bool get isNotBlank => !isBlank;
}

extension NullableStrisngExtensions on String? {
  bool get isNotNullOrBlank => !isNullOrBlank;

  bool get isNullOrBlank => this?.isBlank ?? true;

  String get getRouteName => toString().replaceAll('/', '');

  bool hasMinLengthOf(int value) => (this?.length ?? 0) >= value;

  String orEmpty() => this ?? '';

  String? takeIfNotBlank() => isNotNullOrBlank ? this : null;
}
