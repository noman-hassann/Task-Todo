import 'package:path/path.dart';
import 'package:scanguard/models/all_todo_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  LocalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        is_completed INTEGER NOT NULL,
        is_synced INTEGER NOT NULL
      )
    ''');
  }

  Future<void> addTask(Items task) async {
    final db = await instance.database;
    await db.insert('tasks', task.toMap());
  }

  Future<List<Items>> fetchTasks() async {
    final db = await instance.database;
    final maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Items.fromMap(maps[i]);
    });
  }

  Future<void> updateTask(Items task) async {
    final db = await instance.database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.sId],
    );
  }

  Future<void> deleteTask(String id) async {
    final db = await instance.database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    await db.close();
  }
}
