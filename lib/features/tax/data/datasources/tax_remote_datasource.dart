import 'dart:convert';
import 'dart:io';
import 'package:manuk_pos/core/config/api_config.dart';
import 'package:manuk_pos/features/tax/data/models/tax_model.dart';
import 'package:manuk_pos/features/tax/domain/entities/tax.dart';
import 'package:http/http.dart' as http;

abstract class TaxRemoteDataSource {
  Future<List<Tax>> getAllTaxes();
  Future<Tax> getTaxById(int id);
  Future<Tax> addTax(Tax tax);
  Future<Tax> updateTaxById(int id, Tax tax);
  Future<String> deleteTax(int id);
}

class TaxRemoteDataSourceImpl implements TaxRemoteDataSource {
  final String baseUrl = ApiConfig.taxes();

  @override
  Future<List<Tax>> getAllTaxes() async {
    final response =
        await http.get(Uri.parse(baseUrl)).timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as List<dynamic>;
      return data.map((e) => TaxModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load taxes');
    }
  }

  @override
  Future<Tax> getTaxById(int id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$id'))
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return TaxModel.fromJson(data);
    } else {
      throw Exception('Failed to load tax');
    }
  }

  @override
  Future<Tax> addTax(Tax tax) async {
    final newTaxData = {
      'name': tax.name,
      'rate': tax.rate,
      'is_default': tax.isDefault ? 1 : 0,
      'is_active': tax.isActive,
    };

    final response = await http
        .post(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newTaxData),
        )
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.created) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return TaxModel.fromJson(data);
    } else {
      throw Exception('Failed to create new tax');
    }
  }

  @override
  Future<Tax> updateTaxById(int id, Tax tax) async {
    final updatedData = {
      'name': tax.name,
      'rate': tax.rate,
      'is_default': tax.isDefault ? 1 : 0,
      'is_active': tax.isActive,
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
      return TaxModel.fromJson(data);
    } else {
      throw Exception('Failed to update tax');
    }
  }

  @override
  Future<String> deleteTax(int id) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/$id'))
        .timeout(Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      return decoded['message'];
    } else {
      throw Exception('Failed to delete tax');
    }
  }
}
