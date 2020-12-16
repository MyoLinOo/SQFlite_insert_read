import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = 'todo';
final String column_id = 'id';
final String column_name = 'name';

class Tast {
  int id;
  final String name;

  Tast({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {
      column_name: this.name,
    };
  }
}

class TestHelper {
  Database db;

  TestHelper() {
    initDatabase();
  }
  Future<void> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "my_database.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("db", "my_database.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
// open the database
    db = await openDatabase(path, readOnly: true);

    return db;
    // db = await openDatabase(join(await getDatabasesPath(), 'my_database'),
    //     onCreate: (db, version) {
    //   return db.execute(
    //       'CREATE TABLE $tableName($column_id AUTO INCREMENT PRIMARY KEY,$column_name TEXT)');
    // }, version: 1);
  }

  Future<void> insertTest(Tast test) async {
    try {
      db.insert(tableName, test.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Tast>> getAllTest() async {
    final List<Map<String, dynamic>> tesks = await db.query(tableName);
    return List.generate(tesks.length, (i) {
      return Tast(id: tesks[i][column_id], name: tesks[i][column_name]);
    });
  }
}
