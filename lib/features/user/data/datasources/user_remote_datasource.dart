import 'dart:convert';
import 'dart:io';

import 'package:manuk_pos/core/config/api_config.dart';
import 'package:manuk_pos/features/user/data/models/user_model.dart';
import 'package:manuk_pos/features/user/domain/entities/user.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<List<User>> getAllUsers();
  Future<User> getUserById(int id);
  Future<User> updateUserById(int id, User user);
  Future<User> addUser(User user);
  Future<String> deleteUser(int id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final String baseUrl = ApiConfig.users();

  @override
  Future<List<User>> getAllUsers() async {
    final response =
        await http.get(Uri.parse(baseUrl)).timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as List<dynamic>;
      return data.map((userJson) => UserModel.fromJson(userJson)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Future<User> getUserById(int id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$id'))
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<User> updateUserById(int id, User user) async {
    final updatedData = {
      'name': user.name,
      'username': user.username,
      'email': user.email,
      'phone': user.phone,
      'branch_id': user.branchId,
      'role_id': user.roleId,
      'is_active': user.isActive,
      'login_count': user.loginCount,
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
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to update user');
    }
  }

  @override
  Future<User> addUser(User user) async {
    final newUserData = {
      'name': user.name,
      'username': user.username,
      'email': user.email,
      'phone': user.phone,
      'branch_id': user.branchId,
      'role_id': user.roleId,
      'is_active': user.isActive,
      'login_count': user.loginCount,
    };

    final response = await http
        .post(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newUserData),
        )
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.created) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to create new user');
    }
  }

  @override
  Future<String> deleteUser(int id) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/$id'))
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      return decoded['message'];
    } else {
      throw Exception('Failed to delete user');
    }
  }
}
