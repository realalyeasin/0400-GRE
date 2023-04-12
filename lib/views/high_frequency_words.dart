import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import '../main.dart';
import '../model/model.dart';
import 'package:get/get.dart';

class HighFrequencyWords extends StatefulWidget {
  const HighFrequencyWords({Key? key}) : super(key: key);

  @override
  State<HighFrequencyWords> createState() => _HighFrequencyWordsState();
}

class _HighFrequencyWordsState extends State<HighFrequencyWords> {
  List<WordClass> _items = [];
  List<WordClass> sorted = [];
  List<WordClass> HF = [];
  List<WordClass> MF = [];
  List<WordClass> LF = [];
  var inx = 0.obs;
  var isSelected = false;
  var favorite = false.obs;
  var listIndex = 0.obs;
  var tappedIndex = -100.obs;
  var tappedListIndex = 0;

  final List<String> _frequency = ["High", "Medium", "Low", "High to Low"];

  // the selected value
  String? _selectedAnimal;
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

  update() {
    setState(() {
      listIndex = 0.obs;
    });
    listIndex = 0.obs;
  }

  void _filter() {
    List<WordClass> results = [];
    List<WordClass> results2 = [];
    List<WordClass> results3 = [];
    results = _items.where((element) => element.freq == 5).toList();
    results2 = _items
        .where((element) => element.freq! > 2 && element.freq! < 5)
        .toList();
    results3 = _items
        .where((element) => element.freq! > 0 && element.freq! < 3)
        .toList();
    setState(() {
      HF = results;
      MF = results2;
      LF = results3;
    });
  }

  @override
  initState() {
    // ignore: avoid_print
    readJson();
  }

  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: const Color.fromRGBO(255, 251, 245, 1),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: const Color.fromRGBO(255, 251, 245, 1),
          title: const Text(
            'Frequency Level Words',
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
              child: Container(
                width: 160,
                height: 33,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 251, 245, 1),
                    border: Border.all(color: Colors.black, width: 2)),
                child: DropdownButton<String>(
                  value: _selectedAnimal,
                  onChanged: (value) {
                    setState(() {
                      _selectedAnimal = value;
                      update();
                      listIndex = 0.obs;
                    });
                  },
                  hint: const Center(
                      child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'High to Low',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )),
                  // Hide the default underline
                  underline: Container(),
                  // set the color of the dropdown menu
                  dropdownColor: const Color.fromRGBO(255, 251, 245, 1),

                  icon: const Icon(
                    Icons.arrow_downward,
                    color: Colors.black,
                  ),
                  isExpanded: true,

                  // The list of options
                  items: _frequency
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                e,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ))
                      .toList(),

                  // Customize the selected item
                  selectedItemBuilder: (BuildContext context) => _frequency
                      .map((e) => Center(
                            child: Text(
                              e,
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 12, right: 12, bottom: 2, top: 2),
              child: Container(
                height: 190,
                width: 400,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    color: const Color.fromRGBO(174, 213, 200, 1),
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
                              _selectedAnimal == 'High'
                                  ? Text(
                                      HF[inx.value].word.toString(),
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    )
                                  : _selectedAnimal == 'Medium'
                                      ? Text(
                                          MF[inx.value].word.toString(),
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                        )
                                      : _selectedAnimal == 'Low'
                                          ? Text(
                                              LF[inx.value].word.toString(),
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic),
                                            )
                                          : _selectedAnimal == 'High to Low' ||
                                                  _selectedAnimal == null
                                              ? Text(
                                                  sorted[inx.value]
                                                      .word
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                )
                                              : Container(),
                              const Text(
                                " (",
                                style: TextStyle(fontSize: 19),
                              ),
                              _selectedAnimal == 'High'
                                  ? Text(
                                      _items[inx.value].pos.toString(),
                                      style: const TextStyle(fontSize: 17),
                                    )
                                  : _selectedAnimal == 'Medium'
                                      ? Text(
                                          _items[inx.value].pos.toString(),
                                          style: const TextStyle(fontSize: 17),
                                        )
                                      : _selectedAnimal == 'Low'
                                          ? Text(
                                              _items[inx.value].pos.toString(),
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            )
                                          : _selectedAnimal == 'High to Low' ||
                                                  _selectedAnimal == null
                                              ? Text(
                                                  _items[inx.value]
                                                      .pos
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                )
                                              : Container(),
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
                              const Text('Frequency:',
                                  style: TextStyle(fontSize: 17)),
                              _selectedAnimal == 'High'
                                  ? Text(
                                      HF[inx.value].freq.toString(),
                                      style: const TextStyle(fontSize: 17),
                                    )
                                  : _selectedAnimal == 'Medium'
                                      ? Text(
                                          MF[inx.value].freq.toString(),
                                          style: const TextStyle(fontSize: 17),
                                        )
                                      : _selectedAnimal == 'Low'
                                          ? Text(
                                              LF[inx.value].freq.toString(),
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            )
                                          : _selectedAnimal == 'High to Low' ||
                                                  _selectedAnimal == null
                                              ? Text(
                                                  sorted[inx.value]
                                                      .freq
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                )
                                              : Container(),
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
                                  fontSize: 19, fontWeight: FontWeight.w500)),
                          _selectedAnimal == 'High'
                              ? Text(
                                  HF[inx.value].meaning.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )
                              : _selectedAnimal == 'Medium'
                                  ? Text(
                                      MF[inx.value].meaning.toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    )
                                  : _selectedAnimal == 'Low'
                                      ? Text(
                                          LF[inx.value].meaning.toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        )
                                      : _selectedAnimal == 'High to Low' ||
                                              _selectedAnimal == null
                                          ? Text(
                                              sorted[inx.value]
                                                  .meaning
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          : Container()
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 4),
                      child: Row(
                        children: [
                          Expanded(
                              child: _selectedAnimal == 'High'
                                  ? Text(
                                      HF[inx.value].example.toString(),
                                      maxLines: 3,
                                      softWrap: true,
                                      style: const TextStyle(fontSize: 19),
                                      textAlign: TextAlign.start,
                                    )
                                  : _selectedAnimal == 'Medium'
                                      ? Text(
                                          MF[inx.value].example.toString(),
                                          maxLines: 3,
                                          softWrap: true,
                                          style: const TextStyle(fontSize: 19),
                                          textAlign: TextAlign.start,
                                        )
                                      : _selectedAnimal == 'Low'
                                          ? Text(
                                              LF[inx.value].example.toString(),
                                              maxLines: 3,
                                              softWrap: true,
                                              style:
                                                  const TextStyle(fontSize: 19),
                                              textAlign: TextAlign.start,
                                            )
                                          : _selectedAnimal == 'High to Low' ||
                                                  _selectedAnimal == null
                                              ? Text(
                                                  sorted[inx.value]
                                                      .example
                                                      .toString(),
                                                  maxLines: 3,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                      fontSize: 19),
                                                  textAlign: TextAlign.start,
                                                )
                                              : Container()),
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
                          _selectedAnimal == 'High'
                              ? Text(
                                  HF[inx.value].syn.toString(),
                                  style: const TextStyle(fontSize: 17),
                                )
                              : _selectedAnimal == 'Medium'
                                  ? Text(
                                      MF[inx.value].syn.toString(),
                                      style: const TextStyle(fontSize: 17),
                                    )
                                  : _selectedAnimal == 'Low'
                                      ? Text(
                                          LF[inx.value].syn.toString(),
                                          style: const TextStyle(fontSize: 17),
                                        )
                                      : _selectedAnimal == 'High to Low' ||
                                              _selectedAnimal == null
                                          ? Text(
                                              sorted[inx.value].syn.toString(),
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            )
                                          : Container()
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
                          _selectedAnimal == 'High'
                              ? Text(
                                  HF[inx.value].ant.toString(),
                                  style: const TextStyle(fontSize: 17),
                                )
                              : _selectedAnimal == 'Medium'
                                  ? Text(
                                      MF[inx.value].ant.toString(),
                                      style: const TextStyle(fontSize: 17),
                                    )
                                  : _selectedAnimal == 'Low'
                                      ? Text(
                                          LF[inx.value].ant.toString(),
                                          style: const TextStyle(fontSize: 17),
                                        )
                                      : _selectedAnimal == 'High to Low' ||
                                              _selectedAnimal == null
                                          ? Text(
                                              sorted[inx.value].ant.toString(),
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            )
                                          : Container()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: _selectedAnimal == 'High'
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height - 330,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: HF.length,
                          itemBuilder: (_, listIndex) {
                            return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 8, bottom: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    print(_selectedAnimal);
                                    setState(() {
                                      inx = listIndex.obs;
                                      tappedListIndex = listIndex;
                                      //print(inx);
                                      print(HF[listIndex].meaning.toString());
                                    });
                                  },
                                  child: Container(
                                    height: 53,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 3),
                                        color: tappedListIndex == listIndex
                                            ? const Color.fromRGBO(
                                                174, 213, 200, 1)
                                            : const Color.fromRGBO(
                                                222, 251, 194, 1),
                                        borderRadius: BorderRadius.circular(8)),
                                    // color: isSelected
                                    //     ? Colors.cyan
                                    //     : Colors.lightGreen,
                                    child: GestureDetector(
                                      onTap: () {
                                        isSelected = true;
                                        setState(() {
                                          inx = listIndex.obs;
                                          tappedListIndex = listIndex;
                                          //print(inx);
                                          //print(HF[inx.value].word.toString());
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      HF[listIndex]
                                                          .word
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const Text("  --  "),
                                                    Container(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      HF[listIndex]
                                                          .meaning
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
                                                  ],
                                                ),
                                                /*Obx(
                                                  () => GestureDetector(
                                                onTap: () {
                                                  tappedIndex = index;
                                                  favorite.toggle();
                                                  print('favorite');
                                                },
                                                child: Container(
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
                                            )*/
                                                // Obx(
                                                //   () => GestureDetector(
                                                //     onTap: () {
                                                //       tappedIndex = listIndex;
                                                //       favorite.toggle();
                                                //       print('favorite');
                                                //     },
                                                //     child: Container(
                                                //       width: 20,
                                                //       child: Icon(
                                                //         Icons.favorite,
                                                //         color: favorite.isTrue &&
                                                //                 tappedIndex ==
                                                //                     listIndex
                                                //             ? Colors.red
                                                //             : Colors.grey,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                          }),
                    )
                  : _selectedAnimal == 'Medium'
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height - 330,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: MF.length,
                              itemBuilder: (_, listIndex) {
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 8, bottom: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        print(_selectedAnimal);
                                        setState(() {
                                          inx = listIndex.obs;
                                          tappedListIndex = listIndex;
                                          //print(inx);
                                          //print(MF[inx.value].meaning.toString());
                                        });
                                      },
                                      child: Container(
                                        height: 53,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black, width: 3),
                                            color: tappedListIndex == listIndex
                                                ? const Color.fromRGBO(
                                                    174, 213, 200, 1)
                                                : const Color.fromRGBO(
                                                    222, 251, 194, 1),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        // color: isSelected
                                        //     ? Colors.cyan
                                        //     : Colors.lightGreen,
                                        child: GestureDetector(
                                          onTap: () {
                                            isSelected = true;
                                            setState(() {
                                              inx = listIndex.obs;
                                              tappedListIndex = listIndex;
                                              //print(inx);
                                              //print(MF[inx.value].word.toString());
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 0,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      MF[listIndex]
                                                          .word
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const Text("  --  "),
                                                    Container(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      MF[listIndex]
                                                          .meaning
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
                                                  ],
                                                ),
                                                /*Obx(
                                              () => GestureDetector(
                                            onTap: () {
                                              tappedIndex = index;
                                              favorite.toggle();
                                              print('favorite');
                                            },
                                            child: Container(
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
                                        )*/
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ));
                              }),
                        )
                      : _selectedAnimal == 'Low'
                          ? Container(
                              height: MediaQuery.of(context).size.height - 330,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: LF.length,
                                  itemBuilder: (_, listIndex) {
                                    return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 8,
                                            bottom: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            print(_selectedAnimal);
                                            setState(() {
                                              inx = listIndex.obs;
                                              tappedListIndex = listIndex;
                                              //print(inx);
                                              print(LF[listIndex]
                                                  .meaning
                                                  .toString());
                                            });
                                          },
                                          child: Container(
                                            height: 53,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 3),
                                                color:
                                                    tappedListIndex == listIndex
                                                        ? const Color.fromRGBO(
                                                            174, 213, 200, 1)
                                                        : const Color.fromRGBO(
                                                            222, 251, 194, 1),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            // color: isSelected
                                            //     ? Colors.cyan
                                            //     : Colors.lightGreen,
                                            child: GestureDetector(
                                              onTap: () {
                                                isSelected = true;
                                                setState(() {
                                                  inx = listIndex.obs;
                                                  tappedListIndex = listIndex;
                                                  //print(inx);
                                                  print(LF[listIndex]
                                                      .word
                                                      .toString());
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          LF[listIndex]
                                                              .word
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        const Text("  --  "),
                                                        Container(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          LF[listIndex]
                                                              .meaning
                                                              .toString(),
                                                          maxLines:
                                                              1, // Don't wrap at all
                                                          softWrap:
                                                              false, // Don't wrap at soft breaks
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    /*Obx(
                                              () => GestureDetector(
                                            onTap: () {
                                              tappedIndex = index;
                                              favorite.toggle();
                                              print('favorite');
                                            },
                                            child: Container(
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
                                        )*/
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ));
                                  }),
                            )
                          : _selectedAnimal == null ||
                                  _selectedAnimal == 'High to Low'
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height - 330,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: sorted.length,
                                      itemBuilder: (_, listIndex) {
                                        return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 8,
                                                bottom: 8),
                                            child: GestureDetector(
                                              onTap: () {
                                                print(_selectedAnimal);
                                                setState(() {
                                                  inx = listIndex.obs;
                                                  tappedListIndex = listIndex;
                                                  //print(inx);
                                                  print(sorted[listIndex]
                                                      .meaning
                                                      .toString());
                                                });
                                              },
                                              child: Container(
                                                height: 53,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 3),
                                                    color: tappedListIndex ==
                                                            listIndex
                                                        ? const Color.fromRGBO(
                                                            174, 213, 200, 1)
                                                        : const Color.fromRGBO(
                                                            222, 251, 194, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                // color: isSelected
                                                //     ? Colors.cyan
                                                //     : Colors.lightGreen,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    isSelected = true;
                                                    setState(() {
                                                      inx = listIndex.obs;
                                                      tappedListIndex =
                                                          listIndex;
                                                      //print(inx);
                                                      print(sorted[listIndex]
                                                          .word
                                                          .toString());
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 0,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              sorted[listIndex]
                                                                  .word
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const Text(
                                                                "  --  "),
                                                            Container(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              sorted[listIndex]
                                                                  .meaning
                                                                  .toString(),
                                                              maxLines:
                                                                  1, // Don't wrap at all
                                                              softWrap:
                                                                  false, // Don't wrap at soft breaks
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        /*Obx(
                                              () => GestureDetector(
                                            onTap: () {
                                              tappedIndex = index;
                                              favorite.toggle();
                                              print('favorite');
                                            },
                                            child: Container(
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
                                        )*/
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ));
                                      }),
                                )
                              : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
