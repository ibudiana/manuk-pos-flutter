import 'package:manuk_pos/features/role/domain/entities/role.dart';

class RoleModel extends Role {
  const RoleModel({
    required super.id,
    required super.roleName,
    required super.description,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'],
      roleName: json['role_name'],
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role_name': roleName,
      'description': description,
    };
  }
}
