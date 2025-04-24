import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/role/domain/entities/role.dart';
import 'package:manuk_pos/features/role/domain/repositories/role_repository.dart';

class GetAllRoles {
  final RoleRepository roleRepository;

  GetAllRoles(this.roleRepository);

  Future<Either<Failures, List<Role>>> call() async {
    return await roleRepository.getAllRoles();
  }
}
