import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Exam extends StatefulWidget {
  const Exam({Key? key}) : super(key: key);

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pracrice 1'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Container(), Text('Score 0/10')],
              ),
            ),Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('1. '), Text('Pertinent Means')],
              ),
            ),Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 25,
                color: Colors.orange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ Text('  Relevant')],
                ),
              ),
            ),Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 25,
                color: Colors.orange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ Text('  Copious')],
                ),
              ),
            ),Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 25,
                color: Colors.orange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ Text('  Recent')],
                ),
              ),
            ),Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 25,
                color: Colors.orange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ Text('  Courage')],
                ),
              ),
            ),Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 30,
                color: Colors.cyan,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ Text('  Next')],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
