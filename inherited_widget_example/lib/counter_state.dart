import 'package:flutter/material.dart';
import 'package:inherited_widget_example/counter_widget.dart';

class CounterState extends InheritedWidget {
  const CounterState({
    super.key,
    required this.stateData,
    required super.child,
  });

  final CounterStateData stateData;

  @override
  bool updateShouldNotify(CounterState oldWidget) {
    return oldWidget.stateData.counter != stateData.counter;
  }

  static CounterState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterState>();
  }
}
