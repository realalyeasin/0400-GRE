import 'package:final_project/model/word_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database/word_operations.dart';

class WordList extends StatelessWidget {
  List<WordModel?> wordModel;
  WordOperations? wordOperations = WordOperations();

  WordList(List<WordModel> this.wordModel, {
     Key? key
  }):super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: wordModel.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key('${wordModel[index]?.id}'),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5)),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        ' ${wordModel[index]?.id} ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' ${wordModel[index]?.word}  ${wordModel[index]?.meaning}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: RaisedButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => EditContactPage(
                      //                 contact: wordModel[index],
                      //               )));
                      //     },
                      //     color: Colors.orange,
                      //     child: Icon(Icons.edit, color: Colors.white),
                      //   ),
                      // ),
                    ],
                  ),
                )),
          ),
          onDismissed: (direction) {
            wordOperations?.deleteContact(wordModel[index]!);
          },
        );
      },
    );
  }
}