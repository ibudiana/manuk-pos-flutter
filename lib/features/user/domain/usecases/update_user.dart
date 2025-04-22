import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/user/domain/entities/user.dart';
import 'package:manuk_pos/features/user/domain/repositories/user_repository.dart';

class UpdateUserById {
  final UserRepository userRepository;

  UpdateUserById(this.userRepository);

  Future<Either<Failures, User>> call(int userId, User user) async {
    return await userRepository.updateUserById(userId, user);
  }
}
