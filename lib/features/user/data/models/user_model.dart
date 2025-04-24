import 'package:manuk_pos/features/user/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required int id,
    required int roleId,
    required int branchId,
    required String username,
    required String name,
    required String email,
    required String phone,
    required bool isActive,
    required int loginCount,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          roleId: roleId,
          branchId: branchId,
          username: username,
          name: name,
          email: email,
          phone: phone,
          isActive: isActive,
          loginCount: loginCount,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      roleId: json['role_id'],
      branchId: json['branch_id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      isActive: json['is_active'],
      loginCount: json['login_count'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role_id': roleId,
      'branch_id': branchId,
      'username': username,
      'name': name,
      'email': email,
      'phone': phone,
      'is_active': isActive,
      'login_count': loginCount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
