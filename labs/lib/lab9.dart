import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class CounterInheritedWidget extends InheritedWidget {
  final Counter counter;

  CounterInheritedWidget({required this.counter, required Widget child})
      : super(child: child);

  static CounterInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(CounterInheritedWidget oldWidget) {
    return oldWidget.counter != counter;
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Count: ${counter.count}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text('Просто обновить состояние'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                counter.increment();
              },
              child: Text('Увеличить счетчик'),
            ),
            SizedBox(height: 20),
            CounterInheritedWidget(
              counter: counter,
              child: TextFromInherited(),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFromInherited extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inheritedCounter = CounterInheritedWidget.of(context).counter;

    return Text(
      'Счетчик из InheritedWidget: ${inheritedCounter.count}',
      style: TextStyle(fontSize: 20),
    );
  }
}