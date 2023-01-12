import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeaningPage extends StatefulWidget {
  const MeaningPage({Key? key}) : super(key: key);

  @override
  State<MeaningPage> createState() => _MeaningPageState();
}

class _MeaningPageState extends State<MeaningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(44, 155, 66, 1)),
        child: Center(child: const Text('aaaaaaaaaaaaaaaa')),
      ),
    );
  }
}
