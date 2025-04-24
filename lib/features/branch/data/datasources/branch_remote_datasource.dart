import 'dart:convert';

import 'package:manuk_pos/features/branch/data/models/branch_model.dart';
import 'package:manuk_pos/features/branch/domain/entities/branch.dart';
import 'package:http/http.dart' as http;

abstract class BranchRemoteDataSource {
  Future<List<Branch>> getAllBranches();
  Future<Branch> getBranchById(int id);
  Future<Branch> addBranch(Branch branch);
  Future<Branch> updateBranchById(int id, Branch branch);
  Future<String> deleteBranch(int id);
}

class BranchRemoteDataSourceImpl implements BranchRemoteDataSource {
  final String baseUrl = 'http://10.0.2.2:8080/api/store/branches';

  @override
  Future<List<Branch>> getAllBranches() async {
    final response =
        await http.get(Uri.parse(baseUrl)).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as List<dynamic>;
      return data.map((e) => BranchModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load branches');
    }
  }

  @override
  Future<Branch> getBranchById(int id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$id'))
        .timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return BranchModel.fromJson(data);
    } else {
      throw Exception('Failed to load branch');
    }
  }

  @override
  Future<Branch> addBranch(Branch branch) async {
    final newBranchData = {
      'name': branch.name,
      'address': branch.address,
      'phone': branch.phone,
      "email": branch.email,
      "is_main_branch": branch.isMainBranch,
      "is_active": branch.isActive,
    };

    final response = await http
        .post(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newBranchData),
        )
        .timeout(Duration(seconds: 30));

    if (response.statusCode == 201) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return BranchModel.fromJson(data);
    } else {
      throw Exception('Failed to create new branch');
    }
  }

  @override
  Future<Branch> updateBranchById(int id, Branch branch) async {
    final updatedData = {
      'name': branch.name,
      'address': branch.address,
      'phone': branch.phone,
      "email": branch.email,
      "is_main_branch": branch.isMainBranch,
      "is_active": branch.isActive,
    };

    final response = await http
        .patch(
          Uri.parse('$baseUrl/$id'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(updatedData),
        )
        .timeout(Duration(seconds: 30));

    if (response.statusCode == 201) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return BranchModel.fromJson(data);
    } else {
      throw Exception('Failed to update branch');
    }
  }

  @override
  Future<String> deleteBranch(int id) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/$id'))
        .timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return decoded['message'];
    } else {
      throw Exception('Failed to delete branch');
    }
  }
}
