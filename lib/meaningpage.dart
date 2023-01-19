import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeaningPage extends StatefulWidget {
  const MeaningPage({Key? key}) : super(key: key);

  @override
  State<MeaningPage> createState() => _MeaningPageState();
}

class _MeaningPageState extends State<MeaningPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
          opacity: .7,
        image: AssetImage("images/bgimage.jpg",),
    fit: BoxFit.cover,
    ),),
      child: Scaffold(
        //Color.fromRGBO(255, 247, 239, 1),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height-180,
            width: MediaQuery.of(context).size.width-70,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),color: Colors.cyan,border: Border.all(color: Colors.black,width: 5)),
            child: Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 15,),
                      Text('Pertinent',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(height: 15,),
                      Text('Having precise or logical relevance to the matter at hand',style: TextStyle(fontSize: 17),),
                      SizedBox(height: 19,),
                      Row(children: [
                        Text('Example     '),
                        Expanded(child: Text("A list of articles pertinent to the discussion",softWrap: true,textAlign: TextAlign.justify,maxLines: 5,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600)))
                      ],),

                      SizedBox(height: 15,),
                      Row(children: [
                        Text('Synonym   '),
                        Text("Relevant, Suitable, Applicable",style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600))
                      ],),
                      SizedBox(height: 15,),
                      Row(children: [
                        Text('Antonym   '),
                        Text("Irrelevant, Inappropriate",style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600))
                      ],),
                      SizedBox(height: 20,),
                      Row(children: [
                        Text('PoS            '),
                        Text("Adjective",style: TextStyle(fontSize: 17,))
                      ],),
                      SizedBox(height: 15,),
                      Row(children: [
                        Text('Frequency   '),
                        Text("4.5",style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600))
                      ],),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        height: 30,
                        width: 80,
                        color: Colors.lightGreenAccent,
                        child: Center(child: Text('Back',textAlign: TextAlign.center,)),
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
