import 'package:shared_preferences/shared_preferences.dart';

class LanguageCacheHelper {
  final SharedPreferences sharedPreferences;

  LanguageCacheHelper({required this.sharedPreferences});

  Future<void> cacheLanguageCode(String languageCode) async {
    await sharedPreferences.setString('LOCALE', languageCode);
  }

  Future<String> getCachedLanguageCode() async {
    final cachedLanguageCode = sharedPreferences.getString('LOCALE');
    if (cachedLanguageCode != null) {
      return cachedLanguageCode;
    } else {
      return 'en'; // Default language
    }
  }
}
