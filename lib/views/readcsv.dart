import 'dart:convert';
import 'package:final_project/database/sql_helper.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sort/sort.dart';import 'package:path/path.dart';


import '../practice.dart';
class ReadCSV extends StatefulWidget {
  const ReadCSV({Key? key}) : super(key: key);

  @override
  State<ReadCSV> createState() => _ReadCSVState();
}

class _ReadCSVState extends State<ReadCSV> {

  List<List<dynamic>> data = [];
  var inx=1.obs;
  var isSelected = false;
  var loadDone = false.obs;


  @override
  initState() {
    // ignore: avoid_print
    print("initState Called");
    loadAsset();
    print('Loaded');
  }
  loadAsset() async {
    final myData = await rootBundle.loadString("assets/word.csv");
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(myData);
    data = csvTable;
    print(data);
    loadDoneCheck();
  }
  loadDoneCheck(){
    loadDone.toggle();
  }
  createDB() async {
    Database database = await openDatabase(data as String, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
        });
  }

  Widget build(BuildContext context) {

    return  Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(color: Colors.cyan,child: Image.network('https://tse3.mm.bing.net/th?id=OIP.mSxhoiAZ8nC4DkI05_9PNAEsCy&pid=Api&P=0'),),
            FlatButton(onPressed: (){

            }, child: Text('High Frequency Words')),
            Container(
              child: Column(
                children: [

                  SizedBox(height: 35,),
                  Text('All Words'),
                  SizedBox(height: 15,),
                  Text('Favorite Words'),
                  //SizedBox(height: 15,),
                  //Text('High Frequency Words'),
                  SizedBox(height: 15,),
                  GestureDetector(onTap: (){Get.to(()=>Practice());},child: Text('Practice Session')),
                  SizedBox(height: 15,),
                  Text('Feedback'),
                  SizedBox(height: 15,),
                  Text('Contact Us'),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(title: const Text('CSV Read'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(()=> SingleChildScrollView(
              child: loadDone.isTrue ?   ListView.builder(
                shrinkWrap: true,
              itemCount: data.length
              ,itemBuilder: (_, index){
                return Padding(padding: const EdgeInsets.all(8.0) , child : GestureDetector(
                  onTap: (){

                    setState(() {
                      inx = index.obs;
                      print(inx);
                      print(data[inx.value][3].toString());
                    });
                  },
                  child: Container(
                    color: isSelected ? Colors.cyan : Colors.lightGreen,
                    child: GestureDetector(
                      onTap: (){isSelected = true;},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(data[index][1].toString()),
                            Text("  --  "),
                            Container(width: 10,),
                            Text(data[index][2].toString()),
                          ],
                        ),
                      ),
                    ),),
                )
                );
              }) : Center(child: CircularProgressIndicator(),) ),
          )
          ,
          Obx (()=> loadDone.isTrue ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 110,
              width: 400,
              color: Colors.orange,
              child:  Column(
                children: [
                  Text(data[inx.value][1].toString()),
                  Text(data[inx.value][2].toString()),
                  Text(data[inx.value][3].toString()),
                  Text(data[inx.value][4].toString()),
                  Text(data[inx.value][6].toString()),
                ],
              ),),
          ): Container()
          )
        ],
      ),
    );
  }
}
