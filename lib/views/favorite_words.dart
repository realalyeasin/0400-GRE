import 'dart:convert';
import 'package:flutter_star/flutter_star.dart';
import 'package:final_project/database/db_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expand_view/flutter_expand_view.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:get/get.dart';
import '../model/model.dart';

class FavoriteWords extends StatefulWidget {
  const FavoriteWords({Key? key}) : super(key: key);

  @override
  State<FavoriteWords> createState() => _FavoriteWordsState();
}

class _FavoriteWordsState extends State<FavoriteWords> {
  Future fetchDataFromDB() => fetchFavFromDB();
  List<WordClass> _items = [];
  List<WordClass> sorted = [];
  List<WordClass> HF = [];
  List<WordClass> MF = [];
  List<WordClass> LF = [];
  var inx = 0.obs;
  var w = ''.obs;
  var m = ''.obs;
  var e = ''.obs;
  var s = ''.obs;
  var a = ''.obs;
  var p = ''.obs;
  var f = 1.obs;
  bool expand = false;
  bool isFav = true;
  var isSelected = false;
  var favorite = false.obs;
  var listIndex = 0.obs;
  var tappedIndex = -100.obs;
  var tappedListIndex = 0;

  //final List<String> _frequency = ["High", "Medium", "Low", "High to Low"];

  // the selected value
  String? _selectedAnimal = 'High';
  bool sortDone = false;

  Future<void> readJson() async {
    final String response =
    await rootBundle.rootBundle.loadString('assets/wordjson.json');
    final data = await json.decode(response);

    setState(() {
      _items = List<WordClass>.from(data.map((e) {
        return WordClass.fromJson(e as Map<String, dynamic>);
      }));
    });
    sort();
    if (sortDone == true) {
      _filter();
      //filter2();
    }
  }

  sort() {
    _items.sort((a, b) => b.freq!.toInt().compareTo(a.freq!.toInt()));
    sorted = _items;
    // HF = sorted;
    // MF = sorted;
    print(sorted[0].freq);
    sortDone = true;
  }

  void _filter() {
    List<WordClass> results = [];
    results = _items.where((element) => element.freq == 5).toList();
    setState(() {
      HF = results;
    });
  }

  @override
  initState() {
    // ignore: avoid_print
    readJson();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 251, 245, 1),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color.fromRGBO(255, 251, 245, 1),
        title: const Text(
          'Favorite Words',
          style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 8),
          ),
          Obx(
                () => GestureDetector(
              onTap: () {
                setState(() {
                  expand = !expand;
                });
              },
              child: ExpandChildWidget(
                arrowPadding: const EdgeInsets.only(bottom: 0),
                expand: w != ''.obs ? true : false,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, bottom: 2, top: 2),
                            child: Container(
                              height: 190,
                              width: 400,
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.black, width: 3),
                                  color: const Color.fromRGBO(157, 216, 132, 1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Row(
                                          children: [
                                            Text(
                                              w.toString(),
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
                                              p.toString(),
                                              style:
                                              const TextStyle(fontSize: 17),
                                            ),
                                            const Text(
                                              ")",
                                              style: TextStyle(fontSize: 19),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5, top: 5),
                                        child: Row(
                                          children: [
                                            StarScore(
                                              score: f.value.toDouble(),
                                              star: Star(
                                                  fillColor: Colors.black,
                                                  emptyColor: Colors.black
                                                      .withAlpha(88)),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 8, top: 3),
                                    child: Row(
                                      children: [
                                        const Text(' - ',
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w500)),
                                        Text(
                                          m.toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 8, top: 4),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                              e.toString(),
                                              maxLines: 3,
                                              softWrap: true,
                                              style: const TextStyle(fontSize: 19),
                                              textAlign: TextAlign.start,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 8, top: 10),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Synonyms: ',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Text(
                                          s.toString(),
                                          style: const TextStyle(fontSize: 17),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 8, top: 4),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Antonyms: ',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Text(
                                          a.toString(),
                                          style: const TextStyle(fontSize: 17),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
              child: SizedBox(
                height: expand == false
                    ? MediaQuery.of(context).size.height - 320
                    : MediaQuery.of(context).size.height,
                child: FutureBuilder(
                  future: fetchDataFromDB(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text('Error Occurred $snapshot.error');
                      } else if (snapshot.hasData) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 320,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, index) {
                                final wordData = snapshot.data[index];

                                var map = <String, dynamic>{};
                                wordData.forEach((key, value) => map[key] = value);

                                WordClass favWordClass = WordClass.fromJson(map);

                                return SizedBox(
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 8, bottom: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            w = RxString(
                                                favWordClass.word.toString());
                                            m = RxString(
                                                favWordClass.meaning.toString());
                                            e = RxString(
                                                favWordClass.example.toString());
                                            a = RxString(
                                                favWordClass.ant.toString());
                                            s = RxString(
                                                favWordClass.syn.toString());
                                            p = RxString(
                                                favWordClass.pos.toString());
                                            int ff = int.parse(favWordClass.freq);
                                            f = RxInt(ff);
                                            inx = index.obs;
                                            tappedListIndex = index;
                                          });
                                        },
                                        child: Container(
                                          height: 55,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 3),
                                              color: tappedListIndex == index
                                                  ? const Color.fromRGBO(157, 216, 132, 1)
                                                  : const Color.fromRGBO(
                                                  255, 220, 115, 1),
                                              borderRadius:
                                              BorderRadius.circular(8)),
                                          // color: isSelected
                                          //     ? Colors.cyan
                                          //     : Colors.lightGreen,
                                          child: GestureDetector(
                                            onTap: () {
                                              w = RxString(
                                                  favWordClass.word.toString());
                                              m = RxString(
                                                  favWordClass.meaning.toString());
                                              e = RxString(
                                                  favWordClass.example.toString());
                                              a = RxString(
                                                  favWordClass.ant.toString());
                                              s = RxString(
                                                  favWordClass.syn.toString());
                                              p = RxString(
                                                  favWordClass.pos.toString());
                                              int ff = int.parse(favWordClass.freq);
                                              f = RxInt(ff);
                                              inx = index.obs;
                                              tappedListIndex = index;
                                              inx = index.obs;
                                              tappedListIndex = index;
                                              isSelected = true;
                                              print(inx);
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
                                                        favWordClass.word as String,
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
                                                          favWordClass.meaning
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
                                                      Get.snackbar(
                                                          "Removed Favorite Word",
                                                          "",
                                                          snackPosition:
                                                          SnackPosition.BOTTOM);
                                                      setState(() {
                                                        isFav = !isFav;
                                                        update(favWordClass, isFav);
                                                      });

                                                      // Constants.favWords
                                                      //     .add(
                                                      //         WordClass(
                                                      //   id: wordData.id,
                                                      //   word: wordData
                                                      //       .word,
                                                      //   meaning: wordData
                                                      //       .meaning,
                                                      //   example: wordData
                                                      //       .example,
                                                      //   syn: wordData
                                                      //       .syn,
                                                      //   ant: wordData
                                                      //       .ant,
                                                      //   pos: wordData
                                                      //       .pos,
                                                      //   freq: wordData
                                                      //       .freq,
                                                      //   fvrt: wordData
                                                      //       .fvrt,
                                                      // ));

                                                      //gredb.getData();

                                                      // favrtFunction(
                                                      //     index);
                                                      // setState(() {});
                                                      // String tmpFvrt =
                                                      //     favrtS.toString();
                                                      // gredb.update(
                                                      //     items[index].id!,
                                                      //     favrtS);
                                                      tappedIndex = index;
                                                      favorite.toggle();
                                                    },
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: favWordClass.fvrt == 0
                                                          ? Colors.grey
                                                          : Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                );
                              }),
                        );
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  },
                ),
              )),
        ],
      ),
    );
  }
}
