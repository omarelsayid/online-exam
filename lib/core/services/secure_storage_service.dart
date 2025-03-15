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


}
