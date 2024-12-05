import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter File, SharedPreferences & SQLite',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _fileController = TextEditingController();
  final TextEditingController _prefController = TextEditingController();
  String _fileContent = '';
  String _prefValue = '';
  Database? _database;

  @override
  void initState() {
    super.initState();
    _initDB();
    _loadFromPreferences();
  }

  Future<void> _initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath/demo.db';

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE items(id INTEGER PRIMARY KEY, value TEXT)',
        );
      },
    );
  }

  Future<void> _writeFile() async {
    String text = _fileController.text;
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/my_file.txt');
    await file.writeAsString(text);
  }

  Future<void> _readFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/my_file.txt');
    String contents = await file.readAsString();
    setState(() {
      _fileContent = contents;
    });
  }

  Future<void> _saveToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('my_key', _prefController.text);
  }

  Future<void> _loadFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefValue = prefs.getString('my_key') ?? '';
    });
  }

  Future<void> _insertToDB(String value) async {
    await _database!.insert('items', {'value': value});
  }

  Future<List<Map<String, dynamic>>> _getFromDB() async {
    return await _database!.query('items');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File, SharedPreferences & SQLite')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _fileController,
              decoration: InputDecoration(labelText: 'Enter text for file'),
            ),
            ElevatedButton(
                onPressed: () {
                  _writeFile();
                },
                child: Text('Write to File')),
            ElevatedButton(
                onPressed: () {
                  _readFile();
                },
                child: Text('Read from File')),
            SizedBox(height: 20),
            Text('File Content: $_fileContent'),
            SizedBox(height: 20),
            TextField(
              controller: _prefController,
              decoration: InputDecoration(labelText: 'Enter value for Preferences'),
            ),
            ElevatedButton(
                onPressed: () {
                  _saveToPreferences();
                },
                child: Text('Save to Preferences')),
            ElevatedButton(
                onPressed: () {
                  _loadFromPreferences();
                },
                child: Text('Load from Preferences')),
            SizedBox(height: 20),
            Text('Stored Preference: $_prefValue'),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  String value = _prefController.text;
                  await _insertToDB(value);
                },
                child: Text('Insert to SQLite')),
            ElevatedButton(
                onPressed: () async {
                  List<Map<String, dynamic>> items = await _getFromDB();
                  print(items);
                },
                child: Text('Get from SQLite')),
          ],
        ),
      ),
    );
  }
}