import 'package:manuk_pos/features/splash/domain/repositories/splash_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepositoryImpl implements SplashRepository {
  @override
  Future<bool> isFirstTimeOpen() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('is_first_time') ?? true;

    if (isFirstTime) {
      await prefs.setBool('is_first_time', false);
    }

    return isFirstTime;
  }
}
