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
    var s =0.obs;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent.shade400,
          centerTitle: true,
          title: const Text('GRE Vocabulary',),),
        drawer: Drawer(
          child: Container(
            child: Column(
              children: [
                Image.network('https://tse3.mm.bing.net/th?id=OIP.mSxhoiAZ8nC4DkI05_9PNAEsCy&pid=Api&P=0'),
                Text('All Words')
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
                  itemCount: 50,
                  itemBuilder: (context, index){
                    return
                       Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15,bottom: 7),
                        child: GestureDetector(
                          onTap: (){
                            print('got it');
                            Get.defaultDialog(title: '$index', content: Column(
                              children:  [
                                const Text('Guess the word meaning'),
                                ElevatedButton(onPressed: (){
                                 Get.to(()=>const MeaningPage());
                                }, child: Text('Show'))
                              ],
                            ));
                          },
                          child: Container(
                              height: 45,
                              decoration: BoxDecoration(color: Colors.yellow,border: Border.all(color: Colors.black,width: 2)),
                              child: Center(child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text((index+1).toString()),
                                  )],),
                                  Row(
                                    children: const [
                                      Text('Abc word... '),
                                      Text('Meaning...')
                                    ],
                                  ),
                                  Row(children: [
                                    IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border))
                                  ],)
                                ],))
                          ),
                        )
                    );
                  }),
            )
          ],
        ),
    );
  }
}
