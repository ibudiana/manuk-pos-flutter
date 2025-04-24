import 'package:manuk_pos/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.productCategoryId,
    required super.sku,
    required super.barcode,
    required super.name,
    required super.description,
    required super.buyingPrice,
    required super.sellingPrice,
    required super.minStock,
    required super.isService,
    required super.isActive,
    required super.isFeatured,
    required super.allowFractions,
    required super.imageUrl,
    required super.tags,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      productCategoryId: json['product_category_id'],
      sku: json['sku'],
      barcode: json['barcode'],
      name: json['name'],
      description: json['description'] ?? '',
      buyingPrice: json['buying_price'].toDouble(),
      sellingPrice: json['selling_price'].toDouble(),
      minStock: json['min_stock'],
      isService: json['is_service'] ?? false,
      isActive: json['is_active'] ?? true,
      isFeatured: json['is_featured'] ?? false,
      allowFractions: json['allow_fractions'],
      imageUrl: json['image_url'] ?? '',
      tags: json['tags'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_category_id': productCategoryId,
      'sku': sku,
      'barcode': barcode,
      'name': name,
      'description': description,
      'buying_price': buyingPrice,
      'selling_price': sellingPrice,
      'min_stock': minStock,
      'is_service': isService,
      'is_active': isActive,
      'is_featured': isFeatured,
      'allow_fractions': allowFractions,
      'image_url': imageUrl,
      'tags': tags,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
