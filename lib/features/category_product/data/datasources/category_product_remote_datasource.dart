import 'dart:convert';
import 'dart:io';
import 'package:manuk_pos/core/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:manuk_pos/features/category_product/data/models/category_product_model.dart';
import 'package:manuk_pos/features/category_product/domain/entities/category_product_.dart';

abstract class CategoryRemoteDataSource {
  Future<List<Category>> getAllCategories();
  Future<Category> getCategoryById(int id);
  Future<Category> addCategory(Category category);
  Future<Category> updateCategoryById(int id, Category category);
  Future<String> deleteCategory(int id);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final String baseUrl = ApiConfig.productCategories();

  @override
  Future<List<Category>> getAllCategories() async {
    final response =
        await http.get(Uri.parse(baseUrl)).timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as List<dynamic>;
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Future<Category> getCategoryById(int id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$id'))
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return CategoryModel.fromJson(data);
    } else {
      throw Exception('Failed to load category');
    }
  }

  @override
  Future<Category> addCategory(Category category) async {
    final newCategoryData = {
      'name': category.name,
      'code': category.code,
      'description': category.description,
      'level': category.level,
      'path': category.path,
      'parent_id': category.parentId,
    };

    final response = await http
        .post(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newCategoryData),
        )
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.created) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return CategoryModel.fromJson(data);
    } else {
      throw Exception('Failed to create new category');
    }
  }

  @override
  Future<Category> updateCategoryById(int id, Category category) async {
    final updatedData = {
      'name': category.name,
      'code': category.code,
      'description': category.description,
      'level': category.level,
      'path': category.path,
      'parent_id': category.parentId,
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
      return CategoryModel.fromJson(data);
    } else {
      throw Exception('Failed to update category');
    }
  }

  @override
  Future<String> deleteCategory(int id) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/$id'))
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      return decoded['message'];
    } else {
      throw Exception('Failed to delete category');
    }
  }
}
