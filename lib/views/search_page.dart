import 'dart:convert';
import 'package:dotted_line/dotted_line.dart';
import 'package:final_project/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:get/get.dart';
import '../database/db_word.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);
  String keyword = '';
  var word = 'word';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final gredb = GREDatabase();

  final fieldText = TextEditingController();
  List<WordClass> _items = [];
  List<WordClass> _foundWords = [];
  var favorite = false.obs;
  var tappedIndex = -100.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _query();
  }

  // Future<void> readJson() async {
  //   final String response =
  //       await rootBundle.rootBundle.loadString('assets/wordjson.json');
  //   final data = await json.decode(response);
  //
  //   setState(() {
  //     _items = List<WordClass>.from(data.map((e) {
  //       return WordClass.fromJson(e as Map<String, dynamic>);
  //     }));
  //   });
  // }
  void _query() async {
    final allRows = await gredb.queryAllRows();
    debugPrint('query all rows:');

/*
    for (final row in allRows) {
      debugPrint(row.toString());
    }
*/

    setState(() {
      _items = List<WordClass>.from(allRows!.map((e) {
        return WordClass(
            id: e['id'],
            word: e['word'],
            meaning: e['meaning'],
            example: e['example'],
            syn: e['syn'],
            ant: e['ant'],
            pos: e['pos'],
            freq: e['freq'],
            fvrt: e['fvrt'],);
      }));
    });

    print(allRows);
  }


  void _filter(String key) {
    List<WordClass> results = [];
    if (key.isEmpty) {
      results = _items;
    } else {
      results = _items
          .where((element) =>
              element.word!.toLowerCase().contains(key.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundWords = results;
    });
  }
  favrtFunction(int? index) {
    WordClass data = _foundWords[index!];
    if (_foundWords[index].fvrt == 1) {
      data.fvrt = 0;
      print(data.fvrt);
      print('Not Favorated -- ');
      gredb.update(_foundWords[index].id!,data);
      print(_foundWords[index].fvrt);

    } else {
      data.fvrt = 1;
      print(data.fvrt);
      print(' Favorated -- ');
      gredb.update(_foundWords[index].id!,data);
      print(_foundWords[index].fvrt);

    }
    setState(() {});
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 251, 245, 1),
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color.fromRGBO(255, 251, 245, 1),


          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                onChanged: (fieldText) => _filter(fieldText),
                cursorColor: Colors.black,
                controller: fieldText,
                decoration: InputDecoration(
                    hoverColor: Colors.black,
                    fillColor: Colors.black,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      color: Colors.black,
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        fieldText.clear();
                        setState(() {});
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: _foundWords.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundWords.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 3, top: 8),
                      child: GestureDetector(
                        onTap: () {
                          print('Click');
                          Get.defaultDialog(
                            title: _foundWords[index].word.toString(),
                            titlePadding: const EdgeInsets.only(top: 20),
                            titleStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                            backgroundColor:
                                const                         Color.fromRGBO(203, 228, 222, 1),

                          content: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(' - '),
                                      Text(
                                        _foundWords[index].meaning.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _foundWords[index].example.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: DottedLine(
                                      lineThickness: 2,
                                      lineLength: 260,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Text('Synonyms - '),
                                      Text(
                                        _foundWords[index].syn.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text('Antonyms - '),
                                      Text(
                                        _foundWords[index].ant.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(255, 251, 245, 1),
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2)),
                                          height: 40,
                                          width: 80,
                                          child: const Align(
                                              alignment: Alignment.center,
                                              child: Text('Back')),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          //key: ValueKey(_foundWords[index].id),
                          color: Color.fromRGBO(203, 228, 222, 1),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 0),
                          child: ListTile(
                            leading: const Icon(
                              Icons.stacked_line_chart,
                              color: Colors.white,
                            ),
                            title: Text(
                              _foundWords[index].word.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  color: Color.fromRGBO(46, 79, 79, 1),
                                  fontSize: 22),
                            ),
                            subtitle: Text(
                                _foundWords[index].meaning.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    color: Color.fromRGBO(46, 79, 79, 1),

                                    fontSize: 16)),
                            trailing: Obx(
                                  () => GestureDetector(
                                onTap: () {
                                  favrtFunction(index);
                                  setState(() {});
                                  tappedIndex = index;
                                  favorite.toggle();
                                  print('favorite');
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: favorite.isTrue &&
                                      tappedIndex ==
                                          index
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                            ),
                            // trailing: Text(
                            //     _foundWords[index].id.toString(),
                            //     style: const TextStyle(
                            //         fontWeight: FontWeight.bold,
                            //         letterSpacing: 1,
                            //         color: Colors.black,
                            //         fontSize: 15,
                            //         backgroundColor: Colors.white)),
                          ),
                        ),
                      ),
                    );
                  })
              : const Center(
                  child: Text('Nothing Found'),
                ),
        ),
      ),
    );
  }
}
