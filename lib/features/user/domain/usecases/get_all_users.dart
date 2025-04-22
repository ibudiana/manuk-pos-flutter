import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/user/domain/entities/user.dart';
import 'package:manuk_pos/features/user/domain/repositories/user_repository.dart';

class GetAllUsers {
  final UserRepository userRepository;

  GetAllUsers(this.userRepository);

  Future<Either<Failures, List<User>>> call() async {
    return await userRepository.getAllUsers();
  }
}
