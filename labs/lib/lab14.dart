import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Тестирование Flutter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Counter value: $_counter'),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: Text('Increment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int increment(int value) {
  return value + 1;
}

void main() {
  test('increment should add 1 to the given value', () {
    expect(increment(1), 2);
    expect(increment(2), 3);
  });

  testWidgets('CounterApp increments counter when button is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(CounterApp());

    expect(find.text('Counter value: 0'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Counter value: 1'), findsOneWidget);
  });

  testWidgets('Integration test: check that the counter increases', (WidgetTester tester) async {
    await tester.pumpWidget(CounterApp());

    expect(find.text('Counter value: 0'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Counter value: 1'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Counter value: 2'), findsOneWidget);
  });
}