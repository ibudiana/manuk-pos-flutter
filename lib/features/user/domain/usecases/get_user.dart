import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/user/domain/entities/user.dart';
import 'package:manuk_pos/features/user/domain/repositories/user_repository.dart';

class GetUserById {
  final UserRepository userRepository;

  GetUserById(this.userRepository);

  Future<Either<Failures, User>> call(int userId) async {
    return await userRepository.getUserById(userId);
  }
}
