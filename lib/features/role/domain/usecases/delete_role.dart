import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/role/domain/repositories/role_repository.dart';

class DeleteRole {
  final RoleRepository roleRepository;

  DeleteRole(this.roleRepository);

  Future<Either<Failures, String>> call(int id) async {
    return await roleRepository.deleteRole(id);
  }
}
