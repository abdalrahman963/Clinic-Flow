import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_preference_scope.dart';

class UserPreferencesStore {
  UserPreferencesStore({required SharedPreferences sharedPreferences})
      : _prefs = sharedPreferences;

  final SharedPreferences _prefs;

  String _themeKey(String scope) => 'prefs_${scope}_theme';
  String _localeKey(String scope) => 'prefs_${scope}_locale';

  Future<ThemeMode> getTheme(String scope) async {
    final raw = _prefs.getString(_themeKey(scope)) ??
        (scope == UserPreferenceScope.guest ? _prefs.getString('APP_THEME_MODE') : null);
    return switch (raw) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.light,
    };
  }

  Future<void> setTheme(String scope, ThemeMode mode) async {
    await _prefs.setString(_themeKey(scope), mode.name);
  }

  Future<String> getLocale(String scope) async {
    final raw = _prefs.getString(_localeKey(scope)) ??
        (scope == UserPreferenceScope.guest ? _prefs.getString('LOCALE') : null);
    return raw ?? 'en';
  }

  Future<void> setLocale(String scope, String languageCode) async {
    await _prefs.setString(_localeKey(scope), languageCode);
  }
}
