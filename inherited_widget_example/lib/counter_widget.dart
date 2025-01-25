import 'package:flutter/material.dart';
import 'package:inherited_widget_example/counter_state.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key, required this.child});

  final Widget child;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late int count;

  void incrementCount() {
    setState(() {
      ++count;
    });
  }

  void decrementCount() {
    setState(() {
      --count;
    });
  }

  @override
  void initState() {
    super.initState();
    count = 0;
  }

  @override
  Widget build(BuildContext context) {
    final stateData = CounterStateData(
        counter: count, increment: incrementCount, decrement: decrementCount);

    return CounterState(
      stateData: stateData,
      child: widget.child,
    );
  }
}

class CounterStateData {
  final int counter;
  final VoidCallback increment;
  final VoidCallback decrement;

  CounterStateData({
    required this.counter,
    required this.increment,
    required this.decrement,
  });
}
