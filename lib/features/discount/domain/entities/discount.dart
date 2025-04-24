import 'package:equatable/equatable.dart';

class Discount extends Equatable {
  final int id;
  final int categoryId;
  final int productId;
  final int customerId;
  final String name;
  final String code;
  final String description;
  final String discountType;
  final double discountValue;
  final double minPurchase;
  final double maxDiscount;
  final DateTime startDate;
  final DateTime endDate;
  final int usageLimit;
  final int usageCount;
  final bool isActive;
  final String appliesTo;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Discount({
    required this.id,
    required this.categoryId,
    required this.productId,
    required this.customerId,
    required this.name,
    required this.code,
    required this.description,
    required this.discountType,
    required this.discountValue,
    required this.minPurchase,
    required this.maxDiscount,
    required this.startDate,
    required this.endDate,
    required this.usageLimit,
    required this.usageCount,
    required this.isActive,
    required this.appliesTo,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        categoryId,
        productId,
        customerId,
        name,
        code,
        description,
        discountType,
        discountValue,
        minPurchase,
        maxDiscount,
        startDate,
        endDate,
        usageLimit,
        usageCount,
        isActive,
        appliesTo,
        createdAt,
        updatedAt,
      ];

  get amount => null;
}
