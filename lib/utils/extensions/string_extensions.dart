extension StringExtensions on String {
  bool get isBlank => trim().isEmpty;

  bool get isNotBlank => !isBlank;

  String removeExtraSpacesAndEmptyLines() {
    String textWithoutExtraSpaces = replaceAll(RegExp(r'\s+'), ' ');

    List<String> lines = textWithoutExtraSpaces.split('\n');
    lines.removeWhere((line) => line.trim().isEmpty);
    String resultText = lines.join('\n');

    return resultText;
  }
}

extension NullableStringExtensions on String? {
  bool get isNotNullOrBlank => !isNullOrBlank;

  bool get isNullOrBlank => this?.isBlank ?? true;

  String get getRouteName => toString().replaceAll('/', '');

  bool hasMinLengthOf(int value) => (this?.length ?? 0) >= value;

  String orEmpty() => this ?? '';

  int toInt() => int.parse(this ?? '0');

  String? takeIfNotBlank() => isNotNullOrBlank ? this : null;
}
