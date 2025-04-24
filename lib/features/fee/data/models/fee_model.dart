import 'package:manuk_pos/features/fee/domain/entities/fee.dart';

class FeeModel extends Fee {
  const FeeModel({
    required super.id,
    required super.name,
    required super.feeType,
    required super.feeValue,
    required super.isDefault,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  factory FeeModel.fromJson(Map<String, dynamic> json) {
    return FeeModel(
      id: json['id'],
      name: json['name'],
      feeType: json['fee_type'],
      feeValue: (json['fee_value'] as num).toDouble(),
      isDefault: json['is_default'] == 1,
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'fee_type': feeType,
      'fee_value': feeValue,
      'is_default': isDefault ? 1 : 0,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
