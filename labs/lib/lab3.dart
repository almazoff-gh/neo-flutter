import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Key Example',
      home: KeyExample(),
    );
  }
}

class KeyExample extends StatefulWidget {
  @override
  _KeyExampleState createState() => _KeyExampleState();
}

class _KeyExampleState extends State<KeyExample> {
  int _value1 = 0;
  int _value2 = 0;
  final GlobalKey<_GlobalKeyWidgetState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Keys Example')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UniqueKeyWidget(key: UniqueKey()),

          KeyedValueWidget(key: ValueKey(1), value: _value1),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _value1++;
              });
            },
            child: Text('Increment ValueKey'),
          ),

          KeyedObjectWidget(key: ObjectKey(_value2), value: _value2),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _value2++;
              });
            },
            child: Text('Increment ObjectKey'),
          ),

          PageStorageWidget(key: PageStorageKey('pageStorageKey')),

          GlobalKeyWidget(key: _globalKey),
          ElevatedButton(
            onPressed: () {
              _globalKey.currentState?.changeText();
            },
            child: Text('Change GlobalKey Text'),
          ),
        ],
      ),
    );
  }
}

class UniqueKeyWidget extends StatelessWidget {
  const UniqueKeyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.all(16.0),
      child: Text('I have a UniqueKey!', style: TextStyle(color: Colors.white)),
    );
  }
}

class KeyedValueWidget extends StatefulWidget {
  final int value;

  KeyedValueWidget({Key? key, required this.value}) : super(key: key);

  @override
  _KeyedValueWidgetState createState() => _KeyedValueWidgetState();
}

class _KeyedValueWidgetState extends State<KeyedValueWidget> {
  @override
  Widget build(BuildContext context) {
    return Text('ValueKey Value: ${widget.value}');
  }
}

class KeyedObjectWidget extends StatefulWidget {
  final int value;

  KeyedObjectWidget({Key? key, required this.value}) : super(key: key);

  @override
  _KeyedObjectWidgetState createState() => _KeyedObjectWidgetState();
}

class _KeyedObjectWidgetState extends State<KeyedObjectWidget> {
  @override
  Widget build(BuildContext context) {
    return Text('ObjectKey Value: ${widget.value}');
  }
}

class PageStorageWidget extends StatefulWidget {
  const PageStorageWidget({Key? key}) : super(key: key);

  @override
  _PageStorageWidgetState createState() => _PageStorageWidgetState();
}

class _PageStorageWidgetState extends State<PageStorageWidget> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    final data = PageStorage.of(context)?.readState(context);
    if (data != null) {
      _counter = data;
    }
  }

  @override
  void dispose() {
    PageStorage.of(context)?.writeState(context, _counter);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('PageStorage Value: $_counter'),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
          child: Text('Increment PageStorage Value'),
        ),
      ],
    );
  }
}

class GlobalKeyWidget extends StatefulWidget {
  const GlobalKeyWidget({Key? key}) : super(key: key);

  @override
  _GlobalKeyWidgetState createState() => _GlobalKeyWidgetState();
}

class _GlobalKeyWidgetState extends State<GlobalKeyWidget> {
  String _text = 'Hello, GlobalKey!';

  void changeText() {
    setState(() {
      _text = 'Text changed!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_text);
  }
}
