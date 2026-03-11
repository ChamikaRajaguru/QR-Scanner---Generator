import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/qr_model.dart';

class StorageService {
  final SharedPreferences _prefs;
  static const String _historyKey = 'qr_history';
  static const String _darkModeKey = 'dark_mode';

  StorageService(this._prefs);

  // History
  Future<void> saveQR(QRModel qr) async {
    final history = getHistory();
    history.insert(0, qr);
    await _prefs.setString(_historyKey, jsonEncode(history.map((e) => e.toJson()).toList()));
  }

  List<QRModel> getHistory() {
    final String? historyJson = _prefs.getString(_historyKey);
    if (historyJson == null) return [];
    final List<dynamic> decoded = jsonDecode(historyJson);
    return decoded.map((e) => QRModel.fromJson(e)).toList();
  }

  Future<void> deleteQR(String id) async {
    final history = getHistory();
    history.removeWhere((element) => element.id == id);
    await _prefs.setString(_historyKey, jsonEncode(history.map((e) => e.toJson()).toList()));
  }

  Future<void> clearHistory() async {
    await _prefs.remove(_historyKey);
  }

  // Settings
  bool isDarkMode() {
    return _prefs.getBool(_darkModeKey) ?? false;
  }

  Future<void> setDarkMode(bool value) async {
    await _prefs.setBool(_darkModeKey, value);
  }
}
