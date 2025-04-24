import 'package:manuk_pos/features/supplier/domain/entities/supplier.dart';

class SupplierModel extends Supplier {
  const SupplierModel({
    required super.id,
    required super.taxId,
    required super.code,
    required super.name,
    required super.contactPerson,
    required super.phone,
    required super.email,
    required super.address,
    required super.paymentTerms,
    required super.isActive,
    required super.notes,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      id: json['id'],
      taxId: json['tax_id'],
      code: json['code'],
      name: json['name'],
      contactPerson: json['contact_person'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      paymentTerms: json['payment_terms'],
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
      'contact_person': contactPerson,
      'phone': phone,
      'email': email,
      'address': address,
      'payment_terms': paymentTerms,
      'is_active': isActive,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
