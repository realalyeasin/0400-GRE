import 'dart:convert';
import 'package:final_project/Global_Variables/constants.dart';
import 'package:final_project/views/flash_card.dart';
import 'package:final_project/views/search_page.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' as rootBundle;
import '../database/db_word.dart';
import '../model/model.dart';
import '../practice.dart';
import 'favorite_words.dart';
import 'high_frequency_words.dart';

class ReadCSV extends StatefulWidget {
  ReadCSV({Key? key}) : super(key: key);
  @override
  State<ReadCSV> createState() => _ReadCSVState();
}

class _ReadCSVState extends State<ReadCSV> {
  final gredb = GREDatabase();


  List<WordClass> items = [];
  List<List<dynamic>> data = [];
  var inx = 0.obs;
  var isSelected = false;
  var loadDone = false.obs;
  var favorite = false.obs;
  var check = 0;
  var favrtS = 0;
  var tappedIndex = -100.obs;
  var listIndex = false.obs;
  var tappedListIndex = 0;
  final List<String> _frequency = [
    "High",
    "Medium",
    "Low",
  ];

  // the selected value
  String? _selectedAnimal;
  @override
  initState() {
    // ignore: avoid_print
    print("initState Called");
    loadAsset();
    //createDB();
    ReadJSON();
    readJson();
    loadJsonData();
    print('Loaded');
  }

  loadJsonData() async {
    List<WordClass> wordClass = await ReadJSON();
    print('111');
    print(wordClass[3].meaning);
    return wordClass;
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.rootBundle.loadString('assets/wordjson.json');
    final data = await json.decode(response);


    setState(() {
      items = List<WordClass>.from(data.map((e) {
        return WordClass.fromJson(e as Map<String, dynamic>);
      }));
    });
  }

  var readData = false;

  changeFunc() {
    setState(() {
      readData = !readData;
    });
  }

  favrtFunction(int? index) {
    WordClass data = items[index!];
    if (items[index].fvrt == 1) {
      data.fvrt = 0;
      print(data.fvrt);
      print('Not Favorated -- ');
      gredb.update(items[index].id!,data);
      print(items[index].fvrt);

    } else {
      data.fvrt = 1;
      print(data.fvrt);
      print(' Favorated -- ');
      gredb.update(items[index].id!,data);
      print(items[index].fvrt);

    }
    setState(() {});
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

  // createDB() async {
  //   Database database = await openDatabase(data as String, version: 1,
  //       onCreate: (Database db, int version) async {
  //     var words = 'words';
  //     await db.execute("""CREATE TABLE $words(
  //       id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  //       word TEXT,
  //       meaning TEXT,
  //       example TEXT,
  //       syn TEXT,
  //       ant TEXT,
  //       pos TEXT,
  //       freq INTEGER,
  //       fvrt INTEGER)""");
  //
  //     Batch batch = db.batch();
  //     final wordJson =
  //         await rootBundle.rootBundle.loadString('assets/wordjson.json');
  //     final wordList = json.decode(wordJson) as List<dynamic>;
  //     wordList.forEach((val) {
  //       WordClass word = WordClass.fromMap(val);
  //       batch.insert(words, word.toMap());
  //       print(wordList);
  //
  //       print('WORDLIST');
  //     });
  //
  //     batch.commit();
  //   });
  // }

  Future<List<WordClass>> ReadJSON() async {
    final jsonData =
        await rootBundle.rootBundle.loadString('assets/wordjson.json');
    final list = jsonDecode(jsonData) as List<dynamic>;
    print(list);
    print("////////////////");
    return list.map((e) => WordClass.fromJson(e)).toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 251, 245, 1),
      drawer: Drawer(
        backgroundColor: Color.fromRGBO(255, 251, 245, 1),
        child: Column(
          children: [
            Container(
                color: Colors.cyan,
                child: Image.asset('images/drawerImage.jpg')),
            Container(
              height: 2,
              color: Colors.black,
            ),
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
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Colors.black,
                height: 2,
              ),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(ReadCSV());
                      },
                      child: Text(
                        'All Words',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 1,
                            fontStyle: FontStyle.italic),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(() => HighFrequencyWords());
                      },
                      child: Text(
                        'Frequency Level Words',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 1,
                            fontStyle: FontStyle.italic),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(() => FlashCard());
                      },
                      child: const Text(
                        'Flash Card',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 1,
                            fontStyle: FontStyle.italic),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(()=>FavoriteWords());
                      },
                      child: const Text(
                        'Favorite Words',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 1,
                            fontStyle: FontStyle.italic),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Feedback',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 1,
                            fontStyle: FontStyle.italic),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Contact Us',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 1,
                            fontStyle: FontStyle.italic),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Color.fromRGBO(255, 251, 245, 1),
          title: const Text(
            'GRE Vocabularies',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 2),
          ),
          actions: [
            // Navigate to the Search Screen
            IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage())),
                icon: const Icon(Icons.search))
          ]),
      body: Column(
        children: [
          Obx(() => loadDone.isTrue
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 190,
                    width: 400,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 3),
                        color: const Color.fromRGBO(126, 212, 230, 1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Row(
                                children: [
                                  Text(
                                    items[inx.value].word.toString(),
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Text(
                                    " (",
                                    style: const TextStyle(fontSize: 19),
                                  ),
                                  Text(
                                    items[inx.value].pos.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    ")",
                                    style: const TextStyle(fontSize: 19),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5, top: 5),
                              child: Row(
                                children: [
                                  StarScore(
                                    score: items[inx.value].freq!.toDouble(),
                                    star: Star(
                                        fillColor: Colors.black,
                                        emptyColor: Colors.black.withAlpha(88)),
                                  ),
                                  // Text('Frequency:',
                                  //     style: const TextStyle(fontSize: 17)),
                                  // Text(
                                  //   items[inx.value].freq.toString(),
                                  //   style: const TextStyle(fontSize: 17),
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 3),
                          child: Row(
                            children: [
                              const Text(' - ',
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500)),
                              Text(
                                items[inx.value].meaning.toString(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 4),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  items[inx.value].example.toString(),
                                  maxLines: 3,
                                  softWrap: true,
                                  style: const TextStyle(fontSize: 19),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 10),
                          child: Row(
                            children: [
                              const Text(
                                'Synonyms: ',
                                style: const TextStyle(fontSize: 17),
                              ),
                              Text(
                                items[inx.value].syn.toString(),
                                style: const TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 4),
                          child: Row(
                            children: [
                              const Text(
                                'Antonyms: ',
                                style: const TextStyle(fontSize: 17),
                              ),
                              Text(
                                items[inx.value].ant.toString(),
                                style: const TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
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
                        height: MediaQuery.of(context).size.height - 320,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (_, index) {
                              final wordData  = items[index];
                              return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 8, bottom: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        inx = index.obs;
                                        tappedListIndex = index;
                                        print(inx);
                                        print(items[inx.value]
                                            .meaning
                                            .toString());
                                      });
                                    },
                                    child: Container(
                                      height: 55,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 3),
                                          color: tappedListIndex == index
                                              ? Color.fromRGBO(126, 212, 230, 1)
                                              : Colors.yellowAccent.shade700,
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
                                            print(items[inx.value]
                                                .word
                                                .toString());
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
                                                    items[index]
                                                        .word
                                                        .toString(),
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
                                                      items[index]
                                                          .meaning
                                                          .toString(),
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
                                              Container(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Constants.favWords.add(WordClass(
                                                      id: wordData.id,
                                                      word: wordData.word,
                                                      meaning: wordData.meaning,
                                                      example: wordData.example,
                                                      syn: wordData.syn,
                                                      ant: wordData.ant,
                                                      pos: wordData.pos,
                                                      freq: wordData.freq,
                                                      fvrt: wordData.fvrt,
                                                    ));

                                                    gredb.getData().then((value)  {
                                                      print(value);
                                                    });

                                                    favrtFunction(index);
                                                    setState(() {});
                                                    // String tmpFvrt =
                                                    //     favrtS.toString();
                                                    // gredb.update(
                                                    //     items[index].id!,
                                                    //     favrtS);
                                                    tappedIndex = index;
                                                    favorite.toggle();
                                                    print(items[index].fvrt);
                                                    print(favrtS);
                                                  },
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: items[index].fvrt == 0
                                                        ? Colors.grey
                                                        : Colors.red,
                                                  ),
                                                ),
                                              ),
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
