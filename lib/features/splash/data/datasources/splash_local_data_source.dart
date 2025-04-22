import 'package:shared_preferences/shared_preferences.dart';

abstract class SplashLocalDataSource {
  Future<bool> isFirstTimeOpen();
  Future<void> setNotFirstTime();
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  static const String _keyFirstTime = 'is_first_time';

  @override
  Future<bool> isFirstTimeOpen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyFirstTime) ?? true;
  }

  @override
  Future<void> setNotFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFirstTime, false);
  }
}
