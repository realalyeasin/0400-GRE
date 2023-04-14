import 'package:final_project/model/model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../main.dart';

class DatabaseHelper {
  static const _databaseName = "greDb.db";
  static const _databaseVersion = 1;
  static const table = 'word';
  static const id = 'id';
  static const word = 'word';
  static const meaning = 'meaning';
  static const example = 'example';
  static const syn = 'syn';
  static const ant = 'ant';
  static const pos = 'pos';
  static const freq = 'freq';
  static const fvrt = 'fvrt';

  late Database _db;

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
        $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $word TEXT,
            $meaning TEXT,
            $example TEXT,
            $syn TEXT,
            $ant TEXT,
            $pos TEXT,
            $freq TEXT,
            $fvrt INTEGER)''');
  }

  // Helper methods
  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    return await _db.insert(
      table,
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db.query(table);
  }


  Future<List<Map<String, dynamic>>> queryOnlyFav() async {
    return await _db.query(table, where: '$fvrt = ?', whereArgs: [1]);
  }


  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row, int columnId) async {
    columnId = row[id];
    return await _db.update(
      table,
      row,
      where: '$id = ?',
      whereArgs: [columnId],
    );
  }

  Future<int> updateFav(WordClass wordClass, row) async {
    return await _db
        .update(table, row, where: '$id = ?', whereArgs: [wordClass.id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int myId) async {
    return await _db.delete(
      table,
      where: '$id = ?',
      whereArgs: [myId],
    );
  }
}

//CRUD operations
void insertDataToDB(WordClass wordClass) async {
  Map<String, dynamic> row = wordClass.toMap();
  final id = await dbHelper.insert(row);
  debugPrint('inserted row id: $id');
}


Future fetchFavFromDB() async {
  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await dbHelper.queryOnlyFav();
  return maps.toList();
}

Future fetchWordsFromDB() async {
  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await dbHelper.queryAllRows();
  return maps.toList();
}

void update(WordClass wordClass, bool isFav) async {
  Map<String, dynamic> row = {
    DatabaseHelper.fvrt: isFav == true ? 1 : 0,
  };
  final rowsAffected = await dbHelper.updateFav(wordClass, row);
  debugPrint('updated $rowsAffected row(s)');
}

void delete() async {
  // Assuming that the number of rows is the id for the last row.
  final id = await dbHelper.queryRowCount();
  final rowsDeleted = await dbHelper.delete(id);
  debugPrint('deleted $rowsDeleted row(s): row $id');
}


