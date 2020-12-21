import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = 'todo';
final String column_id = 'id';
final String column_name = 'name';
final String column_pdfname = 'pdfname';
final String colunm_path = 'path';

class Tast {
  final int id;
  final String name;
  final String pdfname;
  final String path;

  Tast({this.id, this.name, this.pdfname, this.path});

  Map<String, dynamic> toMap() {
    return {
      column_name: this.name,
      column_id: this.id,
      column_pdfname: this.pdfname,
      colunm_path: this.path,
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
    var path = join(databasesPath, "your_database.db");

    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {
        print(_);
      }
      ByteData data = await rootBundle.load(join("db", "m_database.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    db = await openDatabase(path, readOnly: false);

    return db;

    // db = await openDatabase(join(await getDatabasesPath(), 'my_database'),
    //     onCreate: (db, version) {
    //   return db.execute(
    //       'CREATE TABLE $tableName($column_id AUTO INCREMENT PRIMARY KEY,$column_name TEXT)');
    // }, version: 1);
  }

  Future<Tast> insertTest(Tast test) async {
    try {
      await db.insert(tableName, test.toMap());
      // conflictAlgorithm: ConflictAlgorithm.replace);
      return test;
    } catch (e) {
      print(e);
    }
  }

  Future<List<Tast>> getAllTest() async {
    final List<Map<String, dynamic>> tesks = await db.query(tableName);
    return List.generate(tesks.length, (i) {
      return Tast(
        id: tesks[i][column_id],
        name: tesks[i][column_name],
        pdfname: tesks[i][column_pdfname],
        path: tesks[i][colunm_path],
      );
    });
  }
}
