import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static late Database _database;

  static Future<void> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final String dbPath = path.join(databasesPath, 'todo.db');

    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, task TEXT, completed INTEGER)',
        );
      },
    );
  }

  static Future<List<Map<String, dynamic>>> getTasks() async {
    return await _database.query('todos');
  }

  static Future<void> insertTask(String task) async {
    await _database.rawInsert(
      'INSERT INTO todos(task, completed) VALUES(?, ?)',
      [task, 0],
    );
  }

  static Future<void> deleteTasks(List<String> tasks) async {
    await _database.rawDelete(
      'DELETE FROM todos WHERE task IN (${tasks.map((_) => '?').join(',')})',
      tasks,
    );
  }
}
