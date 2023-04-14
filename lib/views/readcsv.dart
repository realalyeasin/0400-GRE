import 'dart:async';
import 'dart:convert';
import 'package:final_project/database/db_helpers.dart';
import 'package:final_project/views/flash_card.dart';
import 'package:final_project/views/search_page.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' as rootBundle;
import '../database/db_word.dart';
import '../main.dart';
import '../model/model.dart';
import 'favorite_words.dart';
import 'high_frequency_words.dart';

class ReadCSV extends StatefulWidget {
  ReadCSV({Key? key}) : super(key: key);
  @override
  State<ReadCSV> createState() => _ReadCSVState();
}

class _ReadCSVState extends State<ReadCSV> {
  final gredb = GREDatabase();
  late StreamController _wordController;

  List<WordClass> items = [];
  List<List<dynamic>> data = [];
  var inx = 0.obs;
  var w = 'Ambivalence'.obs;
  var m = 'Lack of Clarity'.obs;
  var e = 'the lesson was fully ambivalant'.obs;
  var s = 'being undecided'.obs;
  var a = 'unperspective'.obs;
  var p = 'adj'.obs;
  var f = 5.obs;
  RxBool isFav = false.obs;
  var isSelected = false;
  RxBool loadDone = false.obs;
  RxBool favorite = false.obs;
  var check = 0;
  Rx<WordClass> myTabWord = WordClass().obs;
  var favrtS = 0;
  var tappedIndex = -100.obs;
  RxBool listIndex = false.obs;
  RxInt tappedListIndex = 0.obs;
  // the selected value

  Future fetchDataFromDB() => fetchWordsFromDB();

  streamWords() async {
    fetchDataFromDB().then((res) async {
      _wordController.add(res);
      return res;
    });
  }

  showSnack() {
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.greenAccent,
        content: Text(
          'Updated',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        )));
  }

  Future<void> _handleRefresh() async {
    fetchDataFromDB().then((res) async {
      _wordController.add(res);
      // showSnack();
      return null;
    });
  }

  Future readJson() async {
    final String response =
        await rootBundle.rootBundle.loadString('assets/wordjson.json');
    final data = await json.decode(response);
    await dbHelper.queryRowCount().then((value) => {
          if (value == 0)
            {
              List<WordClass>.from(data.map((e) {
                insertDataToDB(WordClass.fromJson(e));
                return WordClass.fromJson(e);
              })),
            }
          else
            {}
        });
    return List<WordClass>.from(data.map((e) {
      return WordClass.fromJson(e);
    }));
  }

  var readData = false;
  changeFunc() {
    setState(() {
      readData = !readData;
    });
  }

  loadDoneCheck() {
    loadDone.toggle();
  }

  @override
  initState() {
    super.initState();
    _wordController = StreamController();
    readJson().then((value) {
      myTabWord(value[0]);
      streamWords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 251, 245, 1),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(255, 251, 245, 1),
        child: Column(
          children: [
            Container(
                color: Colors.cyan,
                child: Image.asset('images/drawerImage.jpg')),
            Container(
              height: 2,
              color: Colors.black,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'GRE Vocabulary',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Colors.black,
                height: 2,
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                    onTap: () {
                      Get.offAll(ReadCSV());
                    },
                    child: const Text(
                      'All Words',
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
                      Get.to(() => const HighFrequencyWords());
                    },
                    child: const Text(
                      'Frequency Level Words',
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
                      Get.to(() => const FlashCard());
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
                      Get.to(() => const FavoriteWords());
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
          ],
        ),
      ),
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: const Color.fromRGBO(255, 251, 245, 1),
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
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: _wordController.stream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Text('No Data'),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 80.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              case ConnectionState.active:

              case ConnectionState.done:
                return Obx(
                  () => Column(
                    children: [
                      wordDetails(wordClass: myTabWord.value),
                      const Divider(thickness: 3),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 320,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index) {
                              final wordData = snapshot.data[index];

                              var map = <String, dynamic>{};
                              wordData
                                  .forEach((key, value) => map[key] = value);

                              WordClass wordClass = WordClass.fromJson(map);

                              return SizedBox(
                                child: GestureDetector(
                                  onTap: () {
                                    tappedListIndex(index);
                                    myTabWord(wordClass);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 8, bottom: 8),
                                    child: Container(
                                      height: 55,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 3),
                                          color: tappedListIndex.value == index
                                              ? const Color.fromRGBO(
                                                  126, 212, 230, 1)
                                              : Colors.yellowAccent.shade700,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      // color: isSelected
                                      //     ? Colors.cyan
                                      //     : Colors.lightGreen,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(width: 20),
                                            Row(
                                              children: [
                                                Text(
                                                  wordClass.word as String,
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const Text("  --  "),
                                                Container(
                                                  width: 5,
                                                ),
                                                SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    wordClass.meaning
                                                        .toString(),
                                                    maxLines:
                                                        1, // Don't wrap at all
                                                    softWrap:
                                                        false, // Don't wrap at soft breaks
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                isFav.value = !isFav.value;
                                                update(wordClass, isFav.value);
                                                _handleRefresh();

                                                //tappedIndex = index;
                                                // favorite.toggle();
                                              },
                                              child: Icon(
                                                Icons.favorite,
                                                color: wordClass.fvrt == 0
                                                    ? Colors.grey
                                                    : Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

Widget wordDetails({required WordClass wordClass}) {
  return Padding(
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
                      '${wordClass.word}',
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    const Text(
                      " (",
                      style: TextStyle(fontSize: 19),
                    ),
                    Text(
                      '${wordClass.pos}',
                      style: const TextStyle(fontSize: 17),
                    ),
                    const Text(
                      ")",
                      style: TextStyle(fontSize: 19),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5, top: 5),
                child: Row(
                  children: [
                    if (wordClass.freq != null)
                      StarScore(
                        score: double.parse(wordClass.freq.toString()),
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
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.w500)),
                Text(
                  '${wordClass.meaning}',
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
                    'Example: ${wordClass.example}',
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
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  '${wordClass.syn}',
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
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  '${wordClass.ant}',
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
