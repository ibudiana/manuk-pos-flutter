import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final int roleId;
  final int branchId;
  final String username;
  final String name;
  final String email;
  final String phone;
  final bool isActive;
  final int loginCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.roleId,
    required this.branchId,
    required this.username,
    required this.name,
    required this.email,
    required this.phone,
    required this.isActive,
    required this.loginCount,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        roleId,
        branchId,
        username,
        name,
        email,
        phone,
        isActive,
        loginCount,
        createdAt,
        updatedAt,
      ];
}
