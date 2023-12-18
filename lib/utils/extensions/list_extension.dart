import 'dart:math';

extension ListExtensions<T> on List<T> {
  List<T> copy() => [
    ...this,
  ];

  bool hasMultipleElements() => length > 1;

  T? randomElement() => !isEmpty ? this[Random().nextInt(length - 1)] : null;
}

extension NullableListExtensions<T> on List<T>? {
  List<T> orEmpty() => this ?? [];
}

extension NullableListWithNullableValuesExtensions<T> on List<T?>? {
  List<T>? filterNotNull() => this?.copy().whereType<T>().toList();

  List<T> orEmptyFilterNotNull() => filterNotNull().orEmpty();
}
