import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  static const String _key = 'theme_mode';
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_key);
    if (themeIndex != null) {
      _themeMode = ThemeMode.values[themeIndex];
      notifyListeners();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, mode.index);
  }

  void toggleTheme() {
    final isDark = _themeMode == ThemeMode.dark;
    setThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
  }
}
