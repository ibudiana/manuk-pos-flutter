import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final int productCategoryId;
  final String sku;
  final String barcode;
  final String name;
  final String description;
  final double buyingPrice;
  final double sellingPrice;
  final int minStock;
  final bool isService;
  final bool isActive;
  final bool isFeatured;
  final int allowFractions;
  final String imageUrl;
  final String tags;
  final String createdAt;
  final String updatedAt;

  const Product({
    required this.id,
    required this.productCategoryId,
    required this.sku,
    required this.barcode,
    required this.name,
    required this.description,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.minStock,
    required this.isService,
    required this.isActive,
    required this.isFeatured,
    required this.allowFractions,
    required this.imageUrl,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        productCategoryId,
        sku,
        barcode,
        name,
        description,
        buyingPrice,
        sellingPrice,
        minStock,
        isService,
        isActive,
        isFeatured,
        allowFractions,
        imageUrl,
        tags,
        createdAt,
        updatedAt,
      ];
}
