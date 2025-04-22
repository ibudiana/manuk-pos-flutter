import 'package:manuk_pos/features/splash/domain/repositories/splash_repository.dart';

class CheckFirstTimeOpen {
  final SplashRepository repository;

  CheckFirstTimeOpen(this.repository);

  Future<bool> call() async {
    return await repository.isFirstTimeOpen();
  }
}
