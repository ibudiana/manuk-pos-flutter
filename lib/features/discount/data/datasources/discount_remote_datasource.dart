import 'dart:convert';
import 'package:manuk_pos/features/discount/data/models/discount_model.dart';
import 'package:manuk_pos/features/discount/domain/entities/discount.dart';
import 'package:http/http.dart' as http;

abstract class DiscountRemoteDataSource {
  Future<List<Discount>> getAllDiscounts();
  Future<Discount> getDiscountById(int id);
  Future<Discount> addDiscount(Discount discount);
  Future<Discount> updateDiscountById(int id, Discount discount);
  Future<String> deleteDiscount(int id);
}

class DiscountRemoteDataSourceImpl implements DiscountRemoteDataSource {
  final String baseUrl = 'http://10.0.2.2:8080/api/promotions/discounts';

  @override
  Future<List<Discount>> getAllDiscounts() async {
    final response =
        await http.get(Uri.parse(baseUrl)).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as List<dynamic>;
      return data.map((e) => DiscountModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load discounts');
    }
  }

  @override
  Future<Discount> getDiscountById(int id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$id'))
        .timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return DiscountModel.fromJson(data);
    } else {
      throw Exception('Failed to load discount');
    }
  }

  @override
  Future<Discount> addDiscount(Discount discount) async {
    final newDiscountData = {
      'category_id': discount.categoryId,
      'product_id': discount.productId,
      'customer_id': discount.customerId,
      'name': discount.name,
      'code': discount.code,
      'description': discount.description,
      'discount_type': discount.discountType,
      'discount_value': discount.discountValue,
      'min_purchase': discount.minPurchase,
      'max_discount': discount.maxDiscount,
      'start_date': discount.startDate.toIso8601String(),
      'end_date': discount.endDate.toIso8601String(),
      'usage_limit': discount.usageLimit,
      'usage_count': discount.usageCount,
      'is_active': discount.isActive,
      'applies_to': discount.appliesTo,
    };

    final response = await http
        .post(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newDiscountData),
        )
        .timeout(Duration(seconds: 30));

    if (response.statusCode == 201) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return DiscountModel.fromJson(data);
    } else {
      throw Exception('Failed to create new discount');
    }
  }

  @override
  Future<Discount> updateDiscountById(int id, Discount discount) async {
    final updatedData = {
      'category_id': discount.categoryId,
      'product_id': discount.productId,
      'customer_id': discount.customerId,
      'name': discount.name,
      'code': discount.code,
      'description': discount.description,
      'discount_type': discount.discountType,
      'discount_value': discount.discountValue,
      'min_purchase': discount.minPurchase,
      'max_discount': discount.maxDiscount,
      'start_date': discount.startDate.toIso8601String(),
      'end_date': discount.endDate.toIso8601String(),
      'usage_limit': discount.usageLimit,
      'usage_count': discount.usageCount,
      'is_active': discount.isActive,
      'applies_to': discount.appliesTo,
    };

    final response = await http
        .patch(
          Uri.parse('$baseUrl/$id'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(updatedData),
        )
        .timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return DiscountModel.fromJson(data);
    } else {
      throw Exception('Failed to update discount');
    }
  }

  @override
  Future<String> deleteDiscount(int id) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/$id'))
        .timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return decoded['message'];
    } else {
      throw Exception('Failed to delete discount');
    }
  }
}
