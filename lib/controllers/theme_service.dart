import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wvems_protocols/themes.dart';

// spec: https://gist.github.com/RodBr/37310335c6639f486bb3c8a628052405

class ThemeService extends GetxService {
  static ThemeService get to => Get.find();

  SharedPreferences prefs;

  // App Themes (Light vs Dark)
  final AppTheme _lightTheme = AppTheme.fromType(ThemeType.LightMode);
  AppTheme get lightTheme => _lightTheme;
  final AppTheme _darkTheme = AppTheme.fromType(ThemeType.DarkMode);
  AppTheme get darkTheme => _darkTheme;

  // _themeMode necessary for main.dart calls
  ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;
  set themeMode(value) => _themeMode = value;

  final themeYear = 2019.obs;
//  int get themeYear => _themeYear ?? _defaultYear;
//  set themeYear(int value) => _themeYear = value;

  Future<void> setThemeMode(ThemeMode obj) async {
    // Change theme, then update ThemeMode notifiers
    Get.changeThemeMode(obj);
    _themeMode = obj;

    // Save data for later retrieval
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', _themeMode.toString().split('.')[1]);
  }

  Future<void> setThemeYear(int _year) async {
    // Change themeYear, and update ThemeYear notifiers
    themeYear.value = _year;

    // Save data for later retrieval
    prefs = await SharedPreferences.getInstance();
    await prefs.setInt('year', _year);
  }

  Future<void> getThemeModeFromPreferences() async {
    prefs = await SharedPreferences.getInstance();
    final String themeText = prefs.getString('theme') ?? 'system';
    try {
      _themeMode =
          ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
    } catch (e) {
      _themeMode = ThemeMode.system;
    }
    themeYear.value = prefs.getInt('year') ?? 2019;
  }

  AppTheme getAppThemeFromBrightness(Brightness b) {
    return (b == Brightness.dark) ? _darkTheme : _lightTheme;
  }

  Future<ThemeService> init() async {
    await getThemeModeFromPreferences();
    return this;
  }
}
