import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:who_called_me/models/number_comment.dart';
import 'package:who_called_me/providers/scraper.dart';

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

  Future<List<NumberCommentEntity>> comments({String? number}) async {
    await open();
    List<Map<String, dynamic>> maps;

    if (number != null) {
      number = cleanupNumber(number);
      maps = await _db!
          .query('comments', where: 'number = $number', orderBy: 'timestamp');
    } else {
      maps = await _db!.query('comments', orderBy: 'timestamp');
    }

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

  Future<void> deleteNumber(String number) async {
    await open();
    number = cleanupNumber(number);
    _db!.rawQuery(
        'DELETE FROM comments WHERE number = $number AND isLocal != 1');
  }
}
