import 'package:final_project/views/readcsv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'database/db_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onBoarding/view.dart';
int? initScreen;
final dbHelper = DatabaseHelper();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  await dbHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:
      initScreen == 0 || initScreen == null ? 'OnBoardingPage' : 'HomePage',
      routes: {
        'OnBoardingPage': (context) => OnboardingPage(),
        'HomePage': (context) =>  ReadCSV(),
      },
     // home: ReadCSV(),
    );
  }
}
