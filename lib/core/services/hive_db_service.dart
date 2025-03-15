
import 'dart:convert';

import 'package:hive/hive.dart';
class ExamResultStorage {

  static const String _boxName = "exam_result_box";
  static const String _examResultKey = "exam_results";



  static Future<void> initHive()async{

    await Hive.openBox(_boxName);
  }


  static Box _getBox()
  {
    return Hive.box(_boxName);
  }


  static Future<List<dynamic>> getAllExamResults()async{

    final box = _getBox();
    final existData = box.get(_examResultKey);

    if(existData == null)
      return [];


    if(existData is String)
      return jsonDecode(existData) as List<dynamic>;


    return existData as List<dynamic>;
  }

  static Future<void> addExamResult(Map<String, dynamic> newResult) async {
    final existList = await getAllExamResults();
    existList.add(newResult);

    final box = _getBox();
    await box.put(_examResultKey, jsonEncode(existList));


  }

  static Future<void> clearExamResults() async {
    final box = _getBox();
    await box.delete(_examResultKey);
  }


}