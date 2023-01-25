import 'package:flutter/material.dart';

import 'exam.dart';
import 'package:get/get.dart';
class Practice extends StatefulWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text('Practice'),),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 22.0,
          mainAxisSpacing: 22.0,
          shrinkWrap: true,
          children: List.generate(10, (index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
              child: GestureDetector(
                onTap: (){
                  Get.to(()=>Exam());
                },
                child: Container(
                  child: Center(child: Text('Practice ${index+1}'),),
                  height: 10, width: 10,
                  decoration: BoxDecoration(
                   color: Colors.cyan, borderRadius:
                    BorderRadius.all(Radius.circular(20.0),),
                  ),
                ),
              ),
            );
          },),
        ),
      ),
    ),
    );
  }
}
