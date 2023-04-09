import 'package:final_project/model/model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class GREDatabase {
  static const _databaseName = "gre.db";
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

  Database? _db;
  late int updateId;
  late String updateIt;
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

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

  Future<int?> insert(Map<String, dynamic> row) async {
    return await _db?.insert(table, row);
  }

  Future<List<Map<String, dynamic>>?> queryAllRows() async {
    return await _db?.query(table);
  }

  Future<int> queryRowCount() async {
    final results = await _db?.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }
  Future getData() async {

    final List<Map<String, Object?>> datas = await _db!.query(GREDatabase.table);

print(datas);

    return datas.map((e) => WordClass.fromMap(e)).toList();
  }
  // Future<int> update(updateId) async {
  //   return await _db.update(
  //     table,
  //     updateId,
  //     where: '$id = ?',
  //     whereArgs: [fvrt],
  //   );
  // }

  // Future update( int? iid,int? value) async {
  //   return await _db?.rawUpdate(
  //       'UPDATE $table SET $fvrt = $value  WHERE $id = $iid');
  // }
  Future update(int? id, WordClass data) async {
    return await _db
        ?.update(word, data.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  // Future update(Map<String?, dynamic>? row, int? id,int? value) async{
  //
  //   return _db?.update(
  //       GREDatabase.table,
  //       row,
  //       where: '${GREDatabase.id} = ?',
  //       whereArgs: [value]);
  //
  // }

  Future<int?> delete(int id) async {
    return await _db?.delete(
      table,
      where: '$id = ?',
      whereArgs: [id],
    );
  }

  Future<List?> searchContacts(String keyword) async {
    List<Map<String, dynamic>>? allRows = await _db
        ?.query(table, where: 'word LIKE ?', whereArgs: ['%$keyword%']);
    List? wordClass = allRows
        ?.map((wordClass) => WordClass.fromMap(wordClass))
        .cast()
        .toList();
    return wordClass;
  }
}
