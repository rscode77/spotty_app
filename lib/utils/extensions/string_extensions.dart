extension StringExtensions on String {
  bool get isBlank => trim().isEmpty;

  bool get isNotBlank => !isBlank;
}

extension NullableStringExtensions on String? {
  bool get isNotNullOrBlank => !isNullOrBlank;

  bool get isNullOrBlank => this?.isBlank ?? true;

  bool hasMinLengthOf(int value) => (this?.length ?? 0) >= value;

  String orEmpty() => this ?? '';

  String? takeIfNotBlank() => isNotNullOrBlank ? this : null;
}
