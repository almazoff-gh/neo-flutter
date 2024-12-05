import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Null Safety Example'),
        ),
        body: ExampleWidget(),
      ),
    );
  }
}

class ExampleWidget extends StatelessWidget {
  final List<String>? names;

  ExampleWidget({Key? key, this.names}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayedNames = names ?? ['Default Name'];

    late String greeting;

    if (displayedNames.isNotEmpty) {
      greeting = 'Hello, ${displayedNames[0]}!';
    } else {
      greeting = 'Hello, Guest!';
    }

    return Center(
      child: Text(
        greeting,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}