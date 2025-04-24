import 'package:manuk_pos/features/customer/domain/entities/customer.dart';

class CustomerModel extends Customer {
  const CustomerModel({
    required super.id,
    required super.taxId,
    required super.code,
    required super.name,
    required super.phone,
    required super.email,
    required super.address,
    required super.city,
    required super.postalCode,
    required super.birthdate,
    required super.joinDate,
    required super.customerType,
    required super.creditLimit,
    required super.currentBalance,
    required super.isActive,
    required super.notes,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      taxId: json['tax_id'],
      code: json['code'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      city: json['city'],
      postalCode: json['postal_code'],
      birthdate: DateTime.parse(json['birthdate']),
      joinDate: DateTime.parse(json['join_date']),
      customerType: json['customer_type'],
      creditLimit: (json['credit_limit'] as num?)?.toDouble() ?? 0.0,
      currentBalance: (json['current_balance'] as num?)?.toDouble() ?? 0.0,
      isActive: json['is_active'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tax_id': taxId,
      'code': code,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'city': city,
      'postal_code': postalCode,
      'birthdate': birthdate.toIso8601String(),
      'join_date': joinDate.toIso8601String(),
      'customer_type': customerType,
      'credit_limit': creditLimit,
      'current_balance': currentBalance,
      'is_active': isActive,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
