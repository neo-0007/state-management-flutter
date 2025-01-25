import 'package:flutter/material.dart';
import 'package:inherited_widget_example/counter_state.dart';
import 'package:inherited_widget_example/counter_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterWidget(
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final state = CounterState.of(context);
    final counter = state?.stateData.counter ?? 0;
    final increment = state?.stateData.increment ?? () {};
    final decrement = state?.stateData.decrement ?? () {};

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Counter: $counter',
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: increment,
            child: Text('Increase'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: decrement,
            child: Text('Decrease'),
          ),
        ],
      ),
    );
  }
}
