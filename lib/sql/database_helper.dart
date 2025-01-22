import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:frontend/models/book_model.dart'; 

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
    String path = join(await getDatabasesPath(), 'books.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE books(id TEXT PRIMARY KEY, name TEXT, author TEXT, description TEXT, imagePath TEXT)',
        );
      },
    );
  }

  Future<void> insertBook(Map<String, dynamic> book) async {
    final db = await database;
    await db.insert(
      'books',
      book,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Book>> getBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('books');

    return List.generate(maps.length, (i) {
      return Book(
        id: maps[i]['id'],
        name: maps[i]['name'],
        author: maps[i]['author'],
        description: maps[i]['description'],
        imagePath: maps[i]['imagePath'],
      );
    });
  }

  Future<void> updateBook(Map<String, dynamic> book) async {
    final db = await database;
    await db.update(
      'books',
      book,
      where: 'id = ?',
      whereArgs: [book['id']],
    );
  }

  Future<void> deleteBook(String id) async {
    final db = await database;
    await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
