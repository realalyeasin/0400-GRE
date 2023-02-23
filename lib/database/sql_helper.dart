
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:final_project/model/word_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseRepository  {
   sql.Database? _database;
   DatabaseRepository .privateConstructor();
  static final DatabaseRepository  instance =
  DatabaseRepository .privateConstructor();
  final _databaseName = 'database3';
  final _databaseVersion = 1;



  Future<sql.Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDatabase();
    }
    return null;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await sql.openDatabase(path,
        version: _databaseVersion, onCreate: onCreate);
  }
  Future onCreate(sql.Database db, int version) async {
    await db.execute("""CREATE TABLE words(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        word TEXT,
        meaning TEXT,
        example TEXT,
        syn TEXT,
        ant TEXT,
        pos TEXT,
        freq TEXT,
        fvrt TEXT)""");
  }

  // static Future<sql.Database> db() async {
  //   return sql.openDatabase(
  //     'grewords.db',
  //     version: 1,
  //     onCreate: (sql.Database database, int version) async {
  //       await createTables(database);
  //     },
  //   );
  // }
  //
  // static Future<int> createItem(String word, String? meaning,String? syn,String? ant,String? pos,String? freq,String? fvrt) async {
  //   final db = await SQLHelper.db();
  //
  //   final data = {'word': word, 'meaning': meaning, 'syn': syn, 'ant': ant, 'pos': pos, 'freq': freq, 'fvrt': fvrt};
  //   final id = await db.insert('words', data,
  //       conflictAlgorithm: sql.ConflictAlgorithm.replace);
  //   return id;
  // }
  //
  // static Future<List<Map<String, dynamic>>> getItems() async {
  //   final db = await SQLHelper.db();
  //   return db.query('words', orderBy: "id");
  // }
  //
  // static Future<List<Map<String, dynamic>>> getItem(int id) async {
  //   final db = await SQLHelper.db();
  //   return db.query('words', where: "id = ?", whereArgs: [id], limit: 1);
  // }
  //
  //
  // static Future<int> updateItem(
  //     int id, String word, String? meaning,String? syn,String? ant,String? pos,String? freq,String? fvrt) async {
  //   final db = await SQLHelper.db();
  //
  //   final data = {'word': word, 'meaning': meaning, 'syn': syn, 'ant': ant, 'pos': pos, 'freq': freq, 'fvrt': fvrt};
  //
  //   final result =
  //       await db.update('words', data, where: "id = ?", whereArgs: [id]);
  //   return result;
  // }
  //
  //
  // static Future<void> deleteItem(int id) async {
  //   final db = await SQLHelper.db();
  //   try {
  //     await db.delete("words", where: "id = ?", whereArgs: [id]);
  //   } catch (err) {
  //     debugPrint("Something went wrong when deleting an item: $err");
  //   }
  // }
  // Future<List<WordModel>> searchContacts(String keyword) async {
  //   final db = await dbProvider.database;
  //   List<Map<String, dynamic>> allRows = await db
  //       .query('words', where: 'word LIKE ?', whereArgs: ['%$keyword%']);
  //   List<WordModel> contacts =
  //   allRows.map((word) => WordModel.fromMap(word)).toList();
  //   return contacts;
  // }
}
