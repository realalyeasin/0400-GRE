import 'dart:convert';
import 'package:final_project/database/sql_helper.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sort/sort.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' as rootBundle;
import '../model/model.dart';
import '../practice.dart';

class ReadCSV extends StatefulWidget {
  const ReadCSV({Key? key}) : super(key: key);

  @override
  State<ReadCSV> createState() => _ReadCSVState();
}

class _ReadCSVState extends State<ReadCSV> {
  List<List<dynamic>> data = [];
  var inx = 1.obs;
  var isSelected = false;
  var loadDone = false.obs;
  var favorite = false.obs;
  var listIndex = false.obs;
  var tappedIndex = -100.obs;
  var tappedListIndex = -100.obs;

  @override
  initState() {
    // ignore: avoid_print
    print("initState Called");
    loadAsset();
    createDB();
    print('Loaded');
  }

  loadAsset() async {
    final myData = await rootBundle.rootBundle.loadString("assets/word.csv");
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(myData);
    data = csvTable;
    print(data);
    loadDoneCheck();
  }

  loadDoneCheck() {
    loadDone.toggle();
  }

  createDB() async {
    Database database = await openDatabase(data as String, version: 1,
        onCreate: (Database db, int version) async {
      var words = 'words';
      await db.execute("""CREATE TABLE $words(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        word TEXT,
        meaning TEXT,
        example TEXT,
        syn TEXT,
        ant TEXT,
        pos TEXT,
        freq INTEGER,
        fvrt INTEGER)""");

      Batch batch = db.batch();
      final wordJson = await rootBundle.rootBundle.loadString('assets/wordjson.json');
      final wordList = json.decode(wordJson) as List<dynamic>;
      wordList.forEach((val) {
        WordClass word = WordClass.fromMap(val);
        batch.insert(words, word.toMap());
        print(wordList);
        print('WORDLIST');
      });

      batch.commit();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
                color: Colors.cyan,
                child: Image.asset('images/drawerImage.jpg')),
            SizedBox(
              height: 15,
            ),
            Text(
              'GRE Vocabulary',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.black,
                height: 2,
              ),
            ),
            Container(
              child: Column(
                children: [
                  FlatButton(
                      onPressed: () {}, child: Text('High Frequency Words')),
                  SizedBox(
                    height: 1,
                  ),
                  Text('All Words'),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Favorite Words'),
                  //SizedBox(height: 15,),
                  //Text('High Frequency Words'),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(() => Practice());
                      },
                      child: Text('Practice Session')),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Feedback'),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Contact Us'),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'GRE Vocabularies',
          style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
      ),
      body: Column(
        children: [
          Obx(() => loadDone.isTrue
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 3),
                        color: const Color.fromRGBO(126, 212, 230, 1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Text(
                          data[inx.value][1].toString(),
                          style: const TextStyle(fontSize: 19),
                        ),
                        Text(
                          data[inx.value][2].toString(),
                          style: TextStyle(fontSize: 19),
                        ),
                        Text(
                          data[inx.value][3].toString(),
                          style: TextStyle(fontSize: 19),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          data[inx.value][4].toString(),
                          style: TextStyle(fontSize: 19),
                        ),
                        Text(
                          data[inx.value][5].toString(),
                          style: TextStyle(fontSize: 19),
                        ),
                        Text(
                          data[inx.value][6].toString(),
                          style: const TextStyle(fontSize: 19),
                        ),
                        Text(
                          data[inx.value][7].toString(),
                          style: const TextStyle(fontSize: 19),
                        ),
                      ],
                    ),
                  ),
                )
              : Container()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.black,
              height: 2,
            ),
          ),
          Obx(
            () => SingleChildScrollView(
                child: loadDone.isTrue
                    ? Container(
                        height: MediaQuery.of(context).size.height - 315,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (_, index) {
                              return Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        inx = index.obs;
                                        tappedListIndex = index;
                                        print(inx);
                                        print(data[inx.value][3].toString());
                                      });
                                    },
                                    child: Container(
                                      height: 55,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 3),
                                          color: tappedListIndex == index? Color.fromRGBO(126, 212, 230, 1) :Colors.yellowAccent.shade700,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      // color: isSelected
                                      //     ? Colors.cyan
                                      //     : Colors.lightGreen,
                                      child: GestureDetector(
                                        onTap: () {
                                          isSelected = true;
                                            setState(() {
                                              inx = index.obs;
                                              tappedListIndex = index;
                                              print(inx);
                                              print(data[inx.value][3].toString());
                                            });

                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    data[index][1].toString(),
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text("  --  "),
                                                  Container(
                                                    width: 5,
                                                  ),
                                                  SizedBox(
                                                    width: 120,
                                                    child: Text(
                                                      data[index][2].toString(),
                                                      maxLines:
                                                          1, // Don't wrap at all
                                                      softWrap:
                                                          false, // Don't wrap at soft breaks
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Obx(
                                                () => GestureDetector(
                                                  onTap: () {
                                                    tappedIndex = index;
                                                    favorite.toggle();
                                                    print('favorite');
                                                  },
                                                  child: Container(
                                                    child: Icon(
                                                      Icons
                                                          .favorite,
                                                      color: favorite.isTrue &&
                                                              tappedIndex ==
                                                                  index
                                                          ? Colors.red
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            }),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
          ),
        ],
      ),
    );
  }
}
