import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:manuk_pos/core/config/api_config.dart';
import 'package:manuk_pos/features/customer/data/models/customer_model.dart';
import 'package:manuk_pos/features/customer/domain/entities/customer.dart';

abstract class CustomerRemoteDataSource {
  Future<List<Customer>> getAllCustomer();
  Future<Customer> getCustomerById(int id);
  Future<Customer> addCustomer(Customer customer);
  Future<Customer> updateCustomerById(int id, Customer customer);
  Future<String> deleteCustomer(int id);
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final String baseUrl = ApiConfig.customers();

  @override
  Future<List<Customer>> getAllCustomer() async {
    final response =
        await http.get(Uri.parse(baseUrl)).timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as List<dynamic>;
      return data.map((e) => CustomerModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load customers');
    }
  }

  @override
  Future<Customer> getCustomerById(int id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$id'))
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return CustomerModel.fromJson(data);
    } else {
      throw Exception('Failed to load customer');
    }
  }

  @override
  Future<Customer> addCustomer(Customer customer) async {
    final newCustomerData = {
      'tax_id': customer.taxId,
      // 'code': customer.code,
      'name': customer.name,
      'phone': customer.phone,
      'email': customer.email,
      'address': customer.address,
      'city': customer.city,
      'postal_code': customer.postalCode,
      'birthdate': customer.birthdate.toIso8601String(),
      'join_date': customer.joinDate.toIso8601String(),
      'customer_type': customer.customerType,
      'credit_limit': customer.creditLimit,
      'current_balance': customer.currentBalance,
      'is_active': customer.isActive,
      'notes': customer.notes,
    };

    final response = await http
        .post(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newCustomerData),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.created) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return CustomerModel.fromJson(data);
    } else {
      throw Exception('Failed to create new customer');
    }
  }

  @override
  Future<Customer> updateCustomerById(int id, Customer customer) async {
    final updatedCustomerData = {
      'tax_id': customer.taxId,
      // 'code': customer.code,
      'name': customer.name,
      'phone': customer.phone,
      'email': customer.email,
      'address': customer.address,
      'city': customer.city,
      'postal_code': customer.postalCode,
      // 'birthdate': customer.birthdate.toIso8601String(),
      // 'join_date': customer.joinDate.toIso8601String(),
      'customer_type': customer.customerType,
      'credit_limit': customer.creditLimit,
      'current_balance': customer.currentBalance,
      'is_active': customer.isActive,
      'notes': customer.notes,
    };

    print(updatedCustomerData); //debugging line

    final response = await http
        .patch(
          Uri.parse('$baseUrl/$id'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(updatedCustomerData),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return CustomerModel.fromJson(data);
    } else {
      // Log the full response body for debugging
      print('Error response status: ${response.statusCode}'); //debugging line
      print('Error response body: ${response.body}'); //debugging line
      throw Exception('Failed to update customer: ${response.body}');
    }
  }

  @override
  Future<String> deleteCustomer(int id) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/$id'))
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      return decoded['message'];
    } else {
      throw Exception('Failed to delete customer');
    }
  }
}
