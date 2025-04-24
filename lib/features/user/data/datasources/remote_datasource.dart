import 'dart:convert';

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
  @override
  Future<List<User>> getAllUsers() async {
    Uri url = Uri.parse('http://10.0.2.2:8080/api/users');
    final response = await http.get(url).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as List<dynamic>;

      final List<User> users =
          data.map((userJson) => UserModel.fromJson(userJson)).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Future<User> getUserById(int id) async {
    Uri url = Uri.parse('http://10.0.2.2:8080/api/users/$id');
    final response = await http.get(url).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;

      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<User> updateUserById(int id, User user) async {
    Uri url = Uri.parse('http://10.0.2.2:8080/api/users/$id');

    // Membuat data yang akan dikirim dalam body request
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

    // Mengirimkan request PATCH dengan body dalam format JSON
    final response = await http
        .patch(
          url,
          headers: {
            'Content-Type': 'application/json', // Mengatur header sebagai JSON
          },
          body: json.encode(updatedData), // Mengubah data menjadi JSON
        )
        .timeout(Duration(seconds: 30));

    // Menangani response
    if (response.statusCode == 201) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to update user');
    }
  }

  @override
  Future<User> addUser(User user) async {
    Uri url = Uri.parse('http://10.0.2.2:8080/api/users');
    // Membuat data yang akan dikirim dalam body request
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
    // Mengirimkan request POST dengan body dalam format JSON
    final response = await http
        .post(
          url,
          headers: {
            'Content-Type': 'application/json', // Mengatur header sebagai JSON
          },
          body: json.encode(newUserData), // Mengubah data menjadi JSON
        )
        .timeout(Duration(seconds: 30));

    // Menangani response
    if (response.statusCode == 201) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to create new user');
    }
  }

  @override
  Future<String> deleteUser(int id) async {
    Uri url = Uri.parse('http://10.0.2.2:8080/api/users/$id');
    final response =
        await http.delete(url).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body[
          'message']; // atau return langsung "User deleted successfully"
    } else {
      throw Exception('Failed to delete user');
    }
  }
}
