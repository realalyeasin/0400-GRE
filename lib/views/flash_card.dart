import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flip_card/flip_card.dart';

import 'package:get/get.dart';
import '../model/model.dart';

class FlashCard extends StatefulWidget {
  const FlashCard({Key? key}) : super(key: key);

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  List<WordClass> items = [];
  List<WordClass> HF = [];
  List<WordClass> MF = [];
  List<WordClass> LF = [];

  final List<String> _frequency = ["High", "Medium", "Low", "High to Low"];
  var inx = 0.obs;
  var isSelected = false;

  var favorite = false.obs;
  var listIndex = false.obs;
  var tappedIndex = -100.obs;
  var tappedListIndex = -100.obs;
  var cardIndex = 0;
  var cardIndexH = 0;
  var cardIndexM = 0;
  var cardIndexL = 0;
  String? _selectedAnimal;
  bool sortDone = false;

  // the selected value

  Future<void> readJson() async {
    final String response =
        await rootBundle.rootBundle.loadString('assets/wordjson.json');
    final data = await json.decode(response);

    setState(() {
      items = List<WordClass>.from(data.map((e) {
        return WordClass.fromJson(e as Map<String, dynamic>);
      }));
    });
    _filter();
  }

  void _filter() {
    List<WordClass> results = [];
    List<WordClass> results2 = [];
    List<WordClass> results3 = [];
    results = items.where((element) => element.freq == 5).toList();
    results2 = items
        .where((element) => element.freq! > 2 && element.freq! < 5)
        .toList();
    results3 = items
        .where((element) => element.freq! > 0 && element.freq! < 3)
        .toList();
    setState(() {
      HF = results;
      MF = results2;
      LF = results3;
      _selectedAnimal = 'High to Low';
    });
  }

  @override
  initState() {
    // ignore: avoid_print
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    items.shuffle();
    items = items;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(247, 239, 229, 1),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor:  const Color.fromRGBO(247, 239, 229, 1),
          title: const Text(
            'Flash Card',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 2),
          ),
        ),
        body: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 8),
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.4), //color of shadow
                                    spreadRadius: 3, //spread radius
                                    blurRadius: 9, // blur radius
                                    offset: const Offset(
                                        0, 1.5), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  )
                                ],
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(255, 251, 245, 1),
                                    width: 3),
                                color: const Color.fromRGBO(255, 251, 245, 1),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(30))),
                            child: const Center(
                              child: Text(
                                'Test Your Vocabulary Skill !',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 251, 245, 1),
                            border: Border.all(color: Colors.black, width: 2)),
                        width: 120,
                        height: 30,
                        child: DropdownButton<String>(
                          value: _selectedAnimal,
                          onChanged: (value) {
                            setState(() {
                              _selectedAnimal = value;
                            });
                          },
                          hint: const Center(
                              child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Frequency',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                          // Hide the default underline
                          underline: Container(),
                          // set the color of the dropdown menu
                          dropdownColor: Color.fromRGBO(255, 251, 245, 1),

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
                                      child: e=='High to Low'? Text(
                                        "Random",
                                        style: const TextStyle(fontSize: 18),
                                      ) : Text(
                                        e,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ))
                              .toList(),

                          // Customize the selected item
                          selectedItemBuilder: (BuildContext context) =>
                              _frequency
                                  .map((e) => Center(
                                        child: e == 'High to Low' ? Text(
                                'Random',
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ) : Text(
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
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlipCard(
                    front: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        height: 190,
                        width: 400,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(255, 251, 245, 1),
                                width: 5),
                            color: const Color.fromRGBO(137, 196, 225, 1),
                            borderRadius: BorderRadius.circular(3)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _selectedAnimal == "High"
                                    ? Text(
                                        HF[cardIndexH].word.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.normal),
                                      )
                                    : _selectedAnimal == "Medium"
                                        ? Text(
                                            MF[cardIndexM].word.toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.normal),
                                          )
                                        : _selectedAnimal == "Low"
                                            ? Text(
                                                LF[cardIndexL].word.toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.normal),
                                              )
                                            :  _selectedAnimal == "High to Low"
                                                ? Text(
                                                    items[cardIndex]
                                                        .word
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.normal),
                                                  )
                                                : Container(),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromRGBO(
                                                255, 251, 245, 1),
                                            width: 3),
                                        color: const Color.fromRGBO(
                                            238, 238, 238, 1),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Center(
                                      child: GestureDetector(
                                        child: const Text(
                                          'Show',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromRGBO(15, 4, 76, 1),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_selectedAnimal == 'High') {
                                        cardIndexH++;
                                      }
                                      if (_selectedAnimal == 'Medium') {
                                        cardIndexM++;
                                      }
                                      if (_selectedAnimal == 'Low') {
                                        cardIndexL++;
                                      }
                                      if (_selectedAnimal == 'High to Low') {
                                        cardIndex++;
                                      }
                                      if (cardIndex == items.length) {
                                        cardIndex = 0;
                                      }
                                      if (cardIndexH == HF.length) {
                                        cardIndexH = 0;
                                      }
                                      if (cardIndexM == MF.length) {
                                        cardIndexM = 0;
                                      }
                                      if (cardIndexL == LF.length) {
                                        cardIndexL = 0;
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  255, 251, 245, 1),
                                              width: 3),
                                          color: const Color.fromRGBO(
                                              238, 238, 238, 1),
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            if (_selectedAnimal == 'High') {
                                              cardIndexH++;
                                            }
                                            if (_selectedAnimal == 'Medium') {
                                              cardIndexM++;
                                            }
                                            if (_selectedAnimal == 'Low') {
                                              cardIndexL++;
                                            }
                                            if (_selectedAnimal ==
                                                'High to Low') {
                                              cardIndex++;
                                            }
                                            if (cardIndex == items.length) {
                                              cardIndex = 0;
                                            }
                                            if (cardIndexH == HF.length) {
                                              cardIndexH = 0;
                                            }
                                            if (cardIndexM == MF.length) {
                                              cardIndexM = 0;
                                            }
                                            if (cardIndexL == LF.length) {
                                              cardIndexL = 0;
                                            }
                                            setState(() {});
                                          },
                                          child: const Text(
                                            'Next',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  Color.fromRGBO(15, 4, 76, 1),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    back: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        height: 265,
                        width: 400,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(255, 251, 245, 1),
                                width: 5),
                            color: const Color.fromRGBO(137, 196, 225, 1),
                            borderRadius: BorderRadius.circular(3)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        _selectedAnimal == 'High'
                                            ? Text(
                                                HF[cardIndexH].word.toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              )
                                            : _selectedAnimal == 'Medium'
                                                ? Text(
                                                    MF[cardIndexM]
                                                        .word
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  )
                                                : _selectedAnimal == 'Low'
                                                    ? Text(
                                                        LF[cardIndexL]
                                                            .word
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      )
                                                    : _selectedAnimal ==
                                                            'High to Low'
                                                        ? Text(
                                                            items[cardIndex]
                                                                .word
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                          )
                                                        : Container(),
                                        const SizedBox(
                                          width: 1,
                                        ),
                                        const Text("("),
                                        _selectedAnimal == 'High'
                                            ? Text(
                                                HF[cardIndexH].pos.toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              )
                                            : _selectedAnimal == 'Medium'
                                                ? Text(
                                                    MF[cardIndexM]
                                                        .pos
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  )
                                                : _selectedAnimal == 'Low'
                                                    ? Text(
                                                        LF[cardIndexL]
                                                            .pos
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      )
                                                    : _selectedAnimal ==
                                                            'High to Low'
                                                        ? Text(
                                                            items[cardIndex]
                                                                .pos
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                          )
                                                        : Container(),
                                        const Text(")"),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        _selectedAnimal == 'High'
                                            ? Text(
                                                HF[cardIndexH]
                                                    .meaning
                                                    .toString(),
                                                textAlign: TextAlign.justify,
                                                maxLines: 2,
                                                softWrap: true,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              )
                                            : _selectedAnimal == 'Medium'
                                                ? Text(
                                                    MF[cardIndexM]
                                                        .meaning
                                                        .toString(),
                                                    textAlign:
                                                        TextAlign.justify,
                                                    maxLines: 2,
                                                    softWrap: true,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  )
                                                : _selectedAnimal == 'Low'
                                                    ? Text(
                                                        LF[cardIndexL]
                                                            .meaning
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                        maxLines: 2,
                                                        softWrap: true,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      )
                                                    : _selectedAnimal ==
                                                            'High to Low'
                                                        ? Text(
                                                            items[cardIndex]
                                                                .meaning
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .justify,
                                                            maxLines: 2,
                                                            softWrap: true,
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                          )
                                                        : Container(),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _selectedAnimal == 'High'
                                              ? Text(
                                                  HF[cardIndexH]
                                                      .example
                                                      .toString(),
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                )
                                              : _selectedAnimal == 'Medium'
                                                  ? Text(
                                                      MF[cardIndexM]
                                                          .example
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    )
                                                  : _selectedAnimal == 'Low'
                                                      ? Text(
                                                          LF[cardIndexL]
                                                              .example
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic),
                                                        )
                                                      : _selectedAnimal ==
                                                              'High to Low'
                                                          ? Text(
                                                              items[cardIndex]
                                                                  .example
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: const TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                            )
                                                          : Container(),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Synonym - ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        _selectedAnimal == 'High'
                                            ? Text(
                                                HF[cardIndexH].syn.toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              )
                                            : _selectedAnimal == 'Medium'
                                                ? Text(
                                                    MF[cardIndexM]
                                                        .syn
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  )
                                                : _selectedAnimal == 'Low'
                                                    ? Text(
                                                        LF[cardIndexL]
                                                            .syn
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      )
                                                    : _selectedAnimal ==
                                                            'High to Low'
                                                        ? Text(
                                                            items[cardIndex]
                                                                .syn
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                          )
                                                        : Container(),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Antonym - ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        _selectedAnimal == 'High'
                                            ? Text(
                                                HF[cardIndexH].ant.toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              )
                                            : _selectedAnimal == 'Medium'
                                                ? Text(
                                                    MF[cardIndexM]
                                                        .ant
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  )
                                                : _selectedAnimal == 'Low'
                                                    ? Text(
                                                        LF[cardIndexL]
                                                            .ant
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      )
                                                    : _selectedAnimal ==
                                                            'High to Low'
                                                        ? Text(
                                                            items[cardIndex]
                                                                .ant
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                          )
                                                        : Container(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromRGBO(
                                                255, 251, 245, 1),
                                            width: 3),
                                        color: const Color.fromRGBO(
                                            238, 238, 238, 1),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Center(
                                      child: GestureDetector(
                                        child: const Text(
                                          'Back',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
