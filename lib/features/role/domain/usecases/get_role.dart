import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/role/domain/entities/role.dart';
import 'package:manuk_pos/features/role/domain/repositories/role_repository.dart';

class GetRoleById {
  final RoleRepository roleRepository;

  GetRoleById(this.roleRepository);

  Future<Either<Failures, Role>> call(int id) async {
    return await roleRepository.getRoleById(id);
  }
}
