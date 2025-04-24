import 'dart:convert';
import 'dart:io';
import 'package:manuk_pos/core/config/api_config.dart';
import 'package:manuk_pos/features/role/data/models/role_model.dart';
import 'package:manuk_pos/features/role/domain/entities/role.dart';
import 'package:http/http.dart' as http;

abstract class RoleRemoteDataSource {
  Future<List<Role>> getAllRoles();
  Future<Role> getRoleById(int id);
  Future<Role> addRole(Role role);
  Future<Role> updateRoleById(int id, Role role);
  Future<String> deleteRole(int id);
}

class RoleRemoteDataSourceImpl implements RoleRemoteDataSource {
  // final String baseUrl = 'http://10.0.2.2:8080/api/roles';
  final String baseUrl = ApiConfig.roles();

  @override
  Future<List<Role>> getAllRoles() async {
    final response =
        await http.get(Uri.parse(baseUrl)).timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as List<dynamic>;
      return data.map((e) => RoleModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load roles');
    }
  }

  @override
  Future<Role> getRoleById(int id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$id'))
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return RoleModel.fromJson(data);
    } else {
      throw Exception('Failed to load role');
    }
  }

  @override
  Future<Role> addRole(Role role) async {
    final newRoleData = {
      'role_name': role.roleName,
      'description': role.description,
    };

    final response = await http
        .post(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newRoleData),
        )
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.created) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return RoleModel.fromJson(data);
    } else {
      throw Exception('Failed to create new role');
    }
  }

  @override
  Future<Role> updateRoleById(int id, Role role) async {
    final updatedData = {
      'role_name': role.roleName,
      'description': role.description,
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
      return RoleModel.fromJson(data);
    } else {
      throw Exception('Failed to update role');
    }
  }

  @override
  Future<String> deleteRole(int id) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/$id'))
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      return decoded['message'];
    } else {
      throw Exception('Failed to delete role');
    }
  }
}
