import 'package:final_project/model/word_model.dart';
import 'package:final_project/widget/wordlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database/word_operations.dart';

class SearchPage extends StatefulWidget {
  SearchPage({
    Key? key,
  }) : super(
    key: key,
  );

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  WordOperations wordOperations = WordOperations();
  String? keyword;

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
            Icons.arrow_back, // add custom icons also
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'keyword'),
                  onChanged: (value) {
                    keyword = value;
                    setState(() {

                    });
                  },
                ),
              ),
              FutureBuilder(
                future: wordOperations.searchContacts(keyword!),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print('error');
                  var data = snapshot.data;
                  return snapshot.hasData ? WordList(data as List<WordModel>) : new Center(child: Text('No contacts that include this keyword'),);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}