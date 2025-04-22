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
  }) : super(
          id: id,
          roleId: roleId,
          branchId: branchId,
          username: username,
          name: name,
          email: email,
          phone: phone,
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
    };
  }
}
