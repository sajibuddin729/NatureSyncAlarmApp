import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static SharedPreferences? _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveAlarms(List<Map<String, dynamic>> alarms) async {
    if (_prefs == null) await initialize();
    String alarmsJson = jsonEncode(alarms);
    await _prefs!.setString('alarms', alarmsJson);
  }

  static Future<List<Map<String, dynamic>>> getAlarms() async {
    if (_prefs == null) await initialize();
    String? alarmsJson = _prefs!.getString('alarms');
    
    if (alarmsJson == null) return [];
    
    List<dynamic> decoded = jsonDecode(alarmsJson);
    return decoded.cast<Map<String, dynamic>>();
  }

  static Future<void> saveLocation(String location) async {
    if (_prefs == null) await initialize();
    await _prefs!.setString('location', location);
  }

  static Future<String?> getLocation() async {
    if (_prefs == null) await initialize();
    return _prefs!.getString('location');
  }

  static Future<void> saveBool(String key, bool value) async {
    if (_prefs == null) await initialize();
    await _prefs!.setBool(key, value);
  }

  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    if (_prefs == null) await initialize();
    return _prefs!.getBool(key) ?? defaultValue;
  }
}