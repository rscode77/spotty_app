import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MultiValueListenableBuilder extends StatelessWidget {
  final List<ValueListenable> valueListenables;
  final Widget Function(BuildContext, List<dynamic>) builder;

  const MultiValueListenableBuilder({
    required this.valueListenables,
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _CombinedValueListenable(valueListenables),
      builder: (BuildContext context, dynamic value, Widget? child) {
        return builder(context, value as List<dynamic>);
      },
    );
  }
}

class _CombinedValueListenable extends ValueNotifier<List<dynamic>> {
  _CombinedValueListenable(List<ValueListenable> valueListenables)
      : super(valueListenables.map((v) => v.value).toList()) {
    for (var i = 0; i < valueListenables.length; i++) {
      final index = i;
      valueListenables[i].addListener(() {
        final updatedValues = List<dynamic>.from(value);
        updatedValues[index] = valueListenables[index].value;
        value = updatedValues;
      });
    }
  }
}