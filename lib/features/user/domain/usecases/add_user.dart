import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/user/domain/entities/user.dart';
import 'package:manuk_pos/features/user/domain/repositories/user_repository.dart';

class AddUser {
  final UserRepository userRepository;

  AddUser(this.userRepository);

  Future<Either<Failures, User>> call(User user) async {
    return await userRepository.addUser(user);
  }
}
