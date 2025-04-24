import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/role/domain/entities/role.dart';
import 'package:manuk_pos/features/role/domain/repositories/role_repository.dart';

class UpdateRoleById {
  final RoleRepository roleRepository;

  UpdateRoleById(this.roleRepository);

  Future<Either<Failures, Role>> call(int id, Role role) async {
    return await roleRepository.updateRoleById(id, role);
  }
}
