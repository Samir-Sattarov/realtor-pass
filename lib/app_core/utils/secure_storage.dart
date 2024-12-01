import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage =   FlutterSecureStorage();

  save({required String key, required dynamic value}) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> get({required String key}) async {
    try {
      final value = await storage.read(key: key);
      return value;
    } catch (e) {
      debugPrint('Error reading data: $e');
      return null;
    }
  }

  delete({required String key}) async {
    await storage.delete(key: key);
  }

  deleteAll() async {
    await storage.deleteAll();
  }
}
