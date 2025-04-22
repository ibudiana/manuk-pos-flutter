import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/user/domain/repositories/user_repository.dart';

class DeleteUser {
  final UserRepository userRepository;

  DeleteUser(this.userRepository);

  Future<Either<Failures, String>> call(int userId) async {
    return await userRepository.deleteUser(userId);
  }
}
