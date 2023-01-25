import 'package:final_project/practice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'meaningpage.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var word = [
      'Abridge',
      'Abstain',
      'Abstract',
      'Abundant',
      'Accentuate',
      'Acclaim',
      'Acclaim',
      'Accommodating',
      'Accord',
      'Acute',
      'Adept',
      'Adequate',
    ];
    var mean = [
      ['to shorten','v'],
      ['to shorten','v'],
      ['to shorten','v'],
      ['to shorten','v'],
      ['to shorten','v'],
      ['to shorten','v'],
      ['to shorten','v'],
      ['to shorten','v'],
      ['to shorten','v'],
      ['','aa'],
      ['','aa'],
      ['']
    ];
    var invest;
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 192, 235, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(186, 13, 128, 1),
          centerTitle: true,
          title: const Text('GRE Vocabulary',),),
        drawer: Drawer(
          child: Container(
            child: Column(
              children: [
                Image.network('https://tse3.mm.bing.net/th?id=OIP.mSxhoiAZ8nC4DkI05_9PNAEsCy&pid=Api&P=0'),
                SizedBox(height: 35,),
                Text('All Words'),
                SizedBox(height: 15,),
                Text('Favorite Words'),
                SizedBox(height: 15,),
                Text('High Frequency Words'),
                SizedBox(height: 15,),
                GestureDetector(onTap: (){Get.to(()=>Practice());},child: Text('Practice Session')),
                SizedBox(height: 15,),
                Text('Feedback'),
                SizedBox(height: 15,),
                Text('Contact Us'),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 10),
              child: TextField(
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    labelText: 'Search...',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    icon: Icon(
                      Icons.list,
                      color: Colors.black,
                    )),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                  itemCount: word.length,
                  itemBuilder: (context, index){
                    return
                       Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15,bottom: 7),
                        child: GestureDetector(
                          onTap: (){
                            invest = index;
                          },
                          child: Container(
                              height: 45,
                              decoration: BoxDecoration(color: Color.fromRGBO(214, 227, 181, 1),border: Border.all(color: Colors.white,width: 3)),
                              child: Center(child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text((index+1).toString(),style: TextStyle(color: Colors.black),)
                                  )],),
                                  Row(
                                    children:  [
                                      Text(word[index],style: TextStyle(color: Colors.black),),
                                    ],
                                  ),
                                  Row(children: [
                                    IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,color: Colors.cyan,))
                                  ],)
                                ],))
                          ),
                        )
                    );
                  }),
            ),
            Container(
              height: (MediaQuery.of(context).size.height/100)*23,
              width: MediaQuery.of(context).size.width-10,
              decoration: BoxDecoration(color: Color.fromRGBO(108, 168, 247, 1),border: Border.all(color: Colors.black,width: 4),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(height: 3.3,color: Colors.black,),
                  SizedBox(height: 3,),
                  Container(height: 3,width:MediaQuery.of(context).size.width-50,color: Colors.black,),
                  Column(
                    children: [
                      SizedBox(height: 7,),
                      Text('Abridge - To Shoten',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      SizedBox(height: 4,),
                      Text('We need to abridge the papers in order to make it concise',style: TextStyle(fontSize: 14),),
                      SizedBox(height: 7,),
                      Text('Synonym - compress, diminish, epitomize'),
                      Text('Antonym - enlarge, lengthen, expand'),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text('POS - V.'),
                        SizedBox(width: 10,),
                        Text('Frequency - 4.2'),
                      ],)
                    ],
                  )
                ],
              ),
            ),)
          ],
        ),
    );
  }
}

