import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper{
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE words(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        word TEXT,
        meaning TEXT,
        example TEXT,
        syn TEXT,
        ant TEXT,
        pos TEXT,
        freq TEXT,
        fvrt BOOLEAN NOT NULL)""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'word.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      }
    );
  }

  // static Future<int> createItem(String word, String meaning, String example,String syn,String ant,String pos,String freq, Bool fvrt) async {
  //   final db = await SQLHelper.db();
  //   final data = {
  //
  //   };
  //   final id = await db.insert('words', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  // }

}