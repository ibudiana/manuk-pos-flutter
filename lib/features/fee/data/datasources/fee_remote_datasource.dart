import 'dart:convert';
import 'dart:io';
import 'package:manuk_pos/core/config/api_config.dart';
import 'package:manuk_pos/features/fee/data/models/fee_model.dart';
import 'package:manuk_pos/features/fee/domain/entities/fee.dart';
import 'package:http/http.dart' as http;

abstract class FeeRemoteDataSource {
  Future<List<Fee>> getAllFees();
  Future<Fee> getFeeById(int id);
  Future<Fee> addFee(Fee fee);
  Future<Fee> updateFeeById(int id, Fee fee);
  Future<String> deleteFee(int id);
}

class FeeRemoteDataSourceImpl implements FeeRemoteDataSource {
  final String baseUrl = ApiConfig.fees();

  @override
  Future<List<Fee>> getAllFees() async {
    final response =
        await http.get(Uri.parse(baseUrl)).timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as List<dynamic>;
      return data.map((e) => FeeModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load fees');
    }
  }

  @override
  Future<Fee> getFeeById(int id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$id'))
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return FeeModel.fromJson(data);
    } else {
      throw Exception('Failed to load fee');
    }
  }

  @override
  Future<Fee> addFee(Fee fee) async {
    final newFeeData = {
      'name': fee.name,
      'fee_type': fee.feeType,
      'fee_value': fee.feeValue,
      'is_default': fee.isDefault ? 1 : 0,
      'is_active': fee.isActive,
    };

    final response = await http
        .post(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newFeeData),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.created) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return FeeModel.fromJson(data);
    } else {
      throw Exception('Failed to create new fee');
    }
  }

  @override
  Future<Fee> updateFeeById(int id, Fee fee) async {
    final updatedFeeData = {
      'name': fee.name,
      'fee_type': fee.feeType,
      'fee_value': fee.feeValue,
      'is_default': fee.isDefault ? 1 : 0,
      'is_active': fee.isActive,
    };

    final response = await http
        .patch(
          Uri.parse('$baseUrl/$id'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(updatedFeeData),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return FeeModel.fromJson(data);
    } else {
      throw Exception('Failed to update fee');
    }
  }

  @override
  Future<String> deleteFee(int id) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/$id'))
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      return decoded['message'];
    } else {
      throw Exception('Failed to delete fee');
    }
  }
}
