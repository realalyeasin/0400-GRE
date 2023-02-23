import 'package:final_project/model/word_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database/word_operations.dart';

class AddWord extends StatefulWidget {
  const AddWord({Key? key}) : super(key: key);

  @override
  _AddWordState createState() => _AddWordState();
}

class _AddWordState extends State<AddWord> {
  final _wordController = TextEditingController();
  final _meaningController = TextEditingController();
  WordOperations wordOperations = WordOperations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQFLite Tutorial'),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/homePage');
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _wordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Word'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _meaningController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Meaning'),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final contact = WordModel(
              word: _wordController.text, meaning: _meaningController.text, fvrt: '', example: '', ant: '', syn: '', freq: '', id: 5, pos: '',);
          wordOperations.createContact(contact);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}