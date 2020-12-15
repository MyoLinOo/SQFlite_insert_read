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
    db = await openDatabase(join(await getDatabasesPath(), 'my_db_db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE $tableName($column_id AUTO INCREMENT PRIMARY KEY,$column_name TEXT)');
    }, version: 1);
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
