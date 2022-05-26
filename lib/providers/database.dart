import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:who_called_me/models/number_comment.dart';

class NumberDatabase {
  static const String _dbFile = "who_called_me.db";

  static final NumberDatabase _instance = NumberDatabase._internal();

  Database? _db;

  factory NumberDatabase() => _instance;

  NumberDatabase._internal();

  Future<void> open() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), _dbFile),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE comments(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,'
            'comment TEXT, timestamp INTEGER, number TEXT, isLocal INTEGER)');
      },
      version: 1,
    );
  }

  Future<void> insertComment(NumberCommentEntity comment) async {
    await open();
    await _db?.insert('comments', comment.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort);
  }

  Future<void> insertComments(List<NumberCommentEntity> comments) async {
    for (final comment in comments) {
      await insertComment(comment);
    } 
  }

  Future<List<NumberCommentEntity>> comments() async {
    await open();
    final List<Map<String, dynamic>> maps = await _db!.query('comments');

    return List.generate(maps.length, (i) {
      return NumberCommentEntity(
        id: maps[i]['id'],
        name: maps[i]['name'],
        comment: maps[i]['comment'],
        timestamp: maps[i]['timestamp'],
        number: maps[i]['number'],
        isLocal: maps[i]['isLocal'],
      );
    });
  }
}
