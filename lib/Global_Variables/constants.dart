import 'package:final_project/model/model.dart';
import 'package:get_storage/get_storage.dart';
class Constants {
  static List  favWords = <WordClass>[];
  static const String createDataBox = 'dataBox';
  static final GetStorage dataBox = GetStorage(createDataBox);

}