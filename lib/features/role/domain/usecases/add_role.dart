import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/role/domain/entities/role.dart';
import 'package:manuk_pos/features/role/domain/repositories/role_repository.dart';

class AddRole {
  final RoleRepository roleRepository;

  AddRole(this.roleRepository);

  Future<Either<Failures, Role>> call(Role role) async {
    return await roleRepository.addRole(role);
  }
}
