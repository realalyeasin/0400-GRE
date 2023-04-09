import 'package:final_project/Global_Variables/constants.dart';
import 'package:final_project/database/db_word.dart';
import 'package:final_project/views/add_word.dart';
import 'package:final_project/views/readcsv.dart';
import 'package:final_project/views/search_word.dart';
import 'package:final_project/views/word_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'database/sql_helper.dart';
import 'homepage.dart';

Future<void> main() async {
  final gredb = GREDatabase();
  await GetStorage.init(Constants.createDataBox);

  WidgetsFlutterBinding.ensureInitialized();
  await gredb.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/homePage': (context) => WordView(),
        '/addContactPage': (context) => AddWord(),
        '/searchPage': (context) => SearchPage(),
      },
      home: ReadCSV(),
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   // All journals
//   List<Map<String, dynamic>> _journals = [];
//
//   bool _isLoading = true;
//
//   // This function is used to fetch all data from the database
//   void _refreshJournals() async {
//     final data = await SQLHelper.getItems();
//     setState(() {
//       _journals = data;
//       _isLoading = false;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _refreshJournals(); // Loading the diary when the app starts
//   }
//
//   final TextEditingController _wordController = TextEditingController();
//   final TextEditingController _meaningController = TextEditingController();
//   final TextEditingController _exampleController = TextEditingController();
//   final TextEditingController _synController = TextEditingController();
//   final TextEditingController _antController = TextEditingController();
//   final TextEditingController _freqController = TextEditingController();
//   final TextEditingController _fvrtController = TextEditingController();
//
//   // This function will be triggered when the floating button is pressed
//   // It will also be triggered when you want to update an item
//   void _showForm(int? id) async {
//     if (id != null) {
//       // id == null -> create new item
//       // id != null -> update an existing item
//       final existingJournal =
//       _journals.firstWhere((element) => element['id'] == id);
//       _wordController.text = existingJournal['word'];
//       _meaningController.text = existingJournal['meaning'];
//       _exampleController.text = existingJournal['example'];
//       _synController.text = existingJournal['syn'];
//       _antController.text = existingJournal['ant'];
//       _freqController.text = existingJournal['freq'];
//       _fvrtController.text = existingJournal['fvrt'];
//     }
//
//     showModalBottomSheet(
//         context: context,
//         elevation: 5,
//         isScrollControlled: true,
//         builder: (_) =>
//             Container(
//               padding: EdgeInsets.only(
//                 top: 15,
//                 left: 15,
//                 right: 15,
//                 // this will prevent the soft keyboard from covering the text fields
//                 bottom: MediaQuery
//                     .of(context)
//                     .viewInsets
//                     .bottom + 120,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   TextField(
//                     controller: _wordController,
//                     decoration: const InputDecoration(hintText: 'Word'),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextField(
//                     controller: _meaningController,
//                     decoration: const InputDecoration(hintText: 'Meaning'),
//                   ),TextField(
//                     controller: _exampleController,
//                     decoration: const InputDecoration(hintText: 'Example'),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextField(
//                     controller: _synController,
//                     decoration: const InputDecoration(hintText: 'Synonym'),
//                   ),TextField(
//                     controller: _antController,
//                     decoration: const InputDecoration(hintText: 'Antonym'),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextField(
//                     controller: _freqController,
//                     decoration: const InputDecoration(hintText: 'Frequency'),
//                   ),TextField(
//                     controller: _fvrtController,
//                     decoration: const InputDecoration(hintText: 'Favorite'),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       // Save new journal
//                       if (id == null) {
//                         await _addItem();
//                       }
//
//                       if (id != null) {
//                         await _updateItem(id);
//                       }
//
//                       // Clear the text fields
//                       _wordController.text = '';
//                       _meaningController.text = '';
//
//                       // Close the bottom sheet
//                       Navigator.of(context).pop();
//                     },
//                     child: Text(id == null ? 'Create New' : 'Update'),
//                   )
//                 ],
//               ),
//             ));
//   }
//
// // Insert a new journal to the database
//   Future<void> _addItem() async {
//     await SQLHelper.createItem(
//         _wordController.text, _meaningController.text, _exampleController.text, _synController.text,_antController.text, _freqController.text, _fvrtController.text );
//     _refreshJournals();
//   }
//
//   // Update an existing journal
//   Future<void> _updateItem(int id) async {
//     await SQLHelper.updateItem(
//         id,  _wordController.text, _meaningController.text, _exampleController.text, _synController.text,_antController.text, _freqController.text, _fvrtController.text );
//     _refreshJournals();
//   }
//
//   // Delete an item
//   void _deleteItem(int id) async {
//     await SQLHelper.deleteItem(id);
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       content: Text('Successfully deleted a journal!'),
//     ));
//     _refreshJournals();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//         appBar: AppBar(
//           title: const Text('Kindacode.com'),
//           actions: [
//             // Navigate to the Search Screen
//             IconButton(
//                 onPressed: () => Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (_) => const SearchPage())),
//                 icon: const Icon(Icons.search))
//           ],
//       ),
//       body: _isLoading
//           ? const Center(
//         child: CircularProgressIndicator(),
//       )
//           : ListView.builder(
//         itemCount: _journals.length,
//         itemBuilder: (context, index) =>
//             Card(
//               color: Colors.orange[200],
//               margin: const EdgeInsets.all(15),
//               child: ListTile(
//                   title: Text(_journals[index]['id'].toString()),
//                   subtitle: Text(_journals[index]['meaning']),
//                   trailing: SizedBox(
//                     width: 100,
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () => _showForm(_journals[index]['id']),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () =>
//                               _deleteItem(_journals[index]['id']),
//                         ),
//                       ],
//                     ),
//                   )),
//             ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () => _showForm(null),
//       ),
//     );
//   }
// }
//
//
// class SearchPage extends StatelessWidget {
//   const SearchPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // The search area here
//           title: Container(
//             width: double.infinity,
//             height: 40,
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(5)),
//             child: Center(
//               child: TextField(
//                 decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.search),
//                     suffixIcon: IconButton(
//                       icon: const Icon(Icons.clear),
//                       onPressed: () {
//                         /* Clear the search field */
//                       },
//                     ),
//                     hintText: 'Search...',
//                     border: InputBorder.none),
//               ),
//             ),
//           )),
//     );
//   }
// }
