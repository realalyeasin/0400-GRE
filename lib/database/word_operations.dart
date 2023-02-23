import 'package:final_project/database/sql_helper.dart';

import '../model/word_model.dart';

class WordOperations {
  late WordOperations wordOperations;

  final dbProvider = DatabaseRepository.instance;

  createContact(WordModel wordModel) async {
    final db = await dbProvider.database;
    db?.insert('words', wordModel.toMap());
    print('word inserted');
  }

  updateContact(WordModel wordModel) async {
    final db = await dbProvider.database;
    db?.update('words', wordModel.toMap(),
        where: "id=?", whereArgs: [wordModel.id]);
  }

  deleteContact(WordModel wordModel) async {
    final db = await dbProvider.database;
    await db?.delete('words', where: 'id=?', whereArgs: [wordModel.id]);
  }

  Future<List<WordModel>?> getAllContacts() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows = await db?.query('words');
    List<WordModel>? wordModel =
    allRows?.map((wordModel) => WordModel.fromMap(wordModel)).toList();
    return wordModel;
  }

  Future<List?> searchContacts(String keyword) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows = await db
        ?.query('words', where: 'word LIKE ?', whereArgs: ['%$keyword%']);
    List? wordModel =
    allRows?.map((wordModel) => WordModel.fromMap(wordModel)).toList();
    return wordModel;
  }
}