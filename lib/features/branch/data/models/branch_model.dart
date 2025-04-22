import 'package:manuk_pos/features/branch/domain/entities/branch.dart';

class BranchModel extends Branch {
  const BranchModel({
    required int id,
    required String code,
    required String name,
    required String address,
    required String phone,
    required String email,
    required bool isMainBranch,
    required bool isActive,
  }) : super(
          id: id,
          code: code,
          name: name,
          address: address,
          phone: phone,
          email: email,
          isMainBranch: isMainBranch,
          isActive: isActive,
        );

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      isMainBranch: json['is_main_branch'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'is_main_branch': isMainBranch,
      'is_active': isActive,
    };
  }
}
