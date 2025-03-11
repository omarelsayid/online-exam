import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageService {
  static final FlutterSecureStorage _instance = FlutterSecureStorage();
  static const String _examResultKey= 'examResult';

  static Future<void> setValue(String key, String value) async {
    try {
      await _instance.write(key: key, value: value);
    } catch (e) {
      log('Error saving to secure storage: $e');
    }
  }

  // Retrieve a value
  static Future<String?> getValue(String key) async {
    try {
      return await _instance.read(key: key);
    } catch (e) {
      log('Error reading from secure storage: $e');
      return null;
    }
  }

  // Remove a value
  static Future<void> removeValue(String key) async {
    try {
      await _instance.delete(key: key);
    } catch (e) {
      log('Error deleting from secure storage: $e');
    }
  }


  static Future<List<dynamic>> getAllExamResults()async {
    final existData = await _instance.read(key: _examResultKey);

    if (existData == null)
      return [];

    return jsonDecode(existData) as List<dynamic>;
  }


  static Future<void> addExamResult(Map<String,dynamic> newResult)async{
    final existList = await getAllExamResults();
    existList.add(newResult);

    await _instance.write(key: _examResultKey, value: jsonEncode(existList));
  }

  static Future<void>clearExamResults()async{
    await _instance.delete(key: _examResultKey);
  }
}
