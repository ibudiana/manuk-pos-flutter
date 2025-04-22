import 'package:equatable/equatable.dart';

class Branch extends Equatable {
  final int id;
  final String code;
  final String name;
  final String address;
  final String phone;
  final String email;
  final bool isMainBranch;
  final bool isActive;

  const Branch({
    required this.id,
    required this.code,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.isMainBranch,
    required this.isActive,
  });

  @override
  List<Object?> get props =>
      [id, code, name, address, phone, email, isMainBranch, isActive];
}
