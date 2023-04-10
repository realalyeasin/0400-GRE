import 'package:final_project/model/word_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../database/word_operations.dart';
import '../widget/wordlist.dart';
import 'add_word.dart';

class WordView extends StatefulWidget {
  WordView({Key? key})
      : super(
    key: key,
  );

  @override
  _WordViewState createState() => _WordViewState();
}

class _WordViewState extends State<WordView> {
  WordOperations wordOperations = WordOperations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GRE'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(height: 200,color: Colors.cyan,),
            // FlatButton(onPressed: (){
            //   Get.to(()=> AddWord());
            // }, child: Text('Add Words'))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //HorizontalButtonBar(),
              FutureBuilder(
                future: wordOperations.getAllContacts(),
                builder: (context, snapshot){
                  if(snapshot.hasError) print('error');
                  var data = snapshot.data;
                  return snapshot.hasData ? WordList( data as List<WordModel>) : new Center(child: Text('You have no contacts'),);
                },
              ),
            ],
          ),

        ),
      ),
    );
  }
}