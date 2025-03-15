// database_helper.dart
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'exam_results.db');

    return await openDatabase(
      path,
      version: 5,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade
    );
  }




  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // For simplicity, drop and recreate the table.
    await db.execute('DROP TABLE IF EXISTS exam_results');
    await _onCreate(db, newVersion);
  }


  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE exam_results (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        exam_title TEXT,
        total_questions INTEGER,
        exam_duration INTEGER,
        correct_answers INTEGER,
        time_taken_min INTEGER,
        time_taken_sec INTEGER,
        questions TEXT
      )
    ''');
  }
}
