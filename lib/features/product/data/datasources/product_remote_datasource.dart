import 'dart:convert';
import 'dart:io';
import 'package:manuk_pos/core/config/api_config.dart';
import 'package:manuk_pos/features/product/data/models/product_model.dart';
import 'package:manuk_pos/features/product/domain/entities/product.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductById(int id);
  Future<Product> addProduct(Product product);
  Future<Product> updateProductById(int id, Product product);
  Future<String> deleteProduct(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final String baseUrl = ApiConfig.products();

  @override
  Future<List<Product>> getAllProducts() async {
    final response =
        await http.get(Uri.parse(baseUrl)).timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as List<dynamic>;
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Future<Product> getProductById(int id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$id'))
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return ProductModel.fromJson(data);
    } else {
      throw Exception('Failed to load product');
    }
  }

  @override
  Future<Product> addProduct(Product product) async {
    final newProductData = {
      'product_category_id': product.productCategoryId,
      'sku': product.sku,
      'barcode': product.barcode,
      'name': product.name,
      'description': product.description,
      'buying_price': product.buyingPrice,
      'selling_price': product.sellingPrice,
      'min_stock': product.minStock,
      'is_service': product.isService,
      'is_active': product.isActive,
      'is_featured': product.isFeatured,
      'allow_fractions': product.allowFractions,
      'image_url': product.imageUrl,
      'tags': product.tags,
    };

    final response = await http
        .post(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newProductData),
        )
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.created) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return ProductModel.fromJson(data);
    } else {
      throw Exception('Failed to create new product');
    }
  }

  @override
  Future<Product> updateProductById(int id, Product product) async {
    final updatedData = {
      'product_category_id': product.productCategoryId,
      'sku': product.sku,
      'barcode': product.barcode,
      'name': product.name,
      'description': product.description,
      'buying_price': product.buyingPrice,
      'selling_price': product.sellingPrice,
      'min_stock': product.minStock,
      'is_service': product.isService,
      'is_active': product.isActive,
      'is_featured': product.isFeatured,
      'allow_fractions': product.allowFractions,
      'image_url': product.imageUrl,
      'tags': product.tags,
    };

    final response = await http
        .patch(
          Uri.parse('$baseUrl/$id'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(updatedData),
        )
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return ProductModel.fromJson(data);
    } else {
      throw Exception('Failed to update product');
    }
  }

  @override
  Future<String> deleteProduct(int id) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/$id'))
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      return decoded['message'];
    } else {
      throw Exception('Failed to delete product');
    }
  }
}
