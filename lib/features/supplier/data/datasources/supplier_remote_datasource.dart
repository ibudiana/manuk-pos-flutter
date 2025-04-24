import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:manuk_pos/core/config/api_config.dart';
import 'package:manuk_pos/features/supplier/data/models/supplier_model.dart';
import 'package:manuk_pos/features/supplier/domain/entities/supplier.dart';

abstract class SupplierRemoteDataSource {
  Future<List<Supplier>> getAllSupplier();
  Future<Supplier> getSupplierById(int id);
  Future<Supplier> addSupplier(Supplier supplier);
  Future<Supplier> updateSupplierById(int id, Supplier supplier);
  Future<String> deleteSupplier(int id);
}

class SupplierRemoteDataSourceImpl implements SupplierRemoteDataSource {
  final String baseUrl = ApiConfig.suppliers();

  @override
  Future<List<Supplier>> getAllSupplier() async {
    final response =
        await http.get(Uri.parse(baseUrl)).timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as List<dynamic>;
      return data.map((e) => SupplierModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load suppliers');
    }
  }

  @override
  Future<Supplier> getSupplierById(int id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$id'))
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return SupplierModel.fromJson(data);
    } else {
      throw Exception('Failed to load supplier');
    }
  }

  @override
  Future<Supplier> addSupplier(Supplier supplier) async {
    final newSupplierData = {
      'tax_id': supplier.taxId,
      'code': supplier.code,
      'name': supplier.name,
      'contact_person': supplier.contactPerson,
      'phone': supplier.phone,
      'email': supplier.email,
      'address': supplier.address,
      'payment_terms': supplier.paymentTerms,
      'is_active': supplier.isActive,
      'notes': supplier.notes,
    };

    final response = await http
        .post(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newSupplierData),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.created) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return SupplierModel.fromJson(data);
    } else {
      throw Exception('Failed to create new supplier');
    }
  }

  @override
  Future<Supplier> updateSupplierById(int id, Supplier supplier) async {
    final updatedSupplierData = {
      'tax_id': supplier.taxId,
      'code': supplier.code,
      'name': supplier.name,
      'contact_person': supplier.contactPerson,
      'phone': supplier.phone,
      'email': supplier.email,
      'address': supplier.address,
      'payment_terms': supplier.paymentTerms,
      'is_active': supplier.isActive,
      'notes': supplier.notes,
    };

    final response = await http
        .patch(
          Uri.parse('$baseUrl/$id'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(updatedSupplierData),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return SupplierModel.fromJson(data);
    } else {
      throw Exception('Failed to update supplier');
    }
  }

  @override
  Future<String> deleteSupplier(int id) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/$id'))
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      return decoded['message'];
    } else {
      throw Exception('Failed to delete supplier');
    }
  }
}
