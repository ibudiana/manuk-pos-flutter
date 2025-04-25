import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:manuk_pos/core/config/api_config.dart';
import 'package:manuk_pos/features/transaction/data/models/transaction_model.dart';
import 'package:manuk_pos/features/transaction/domain/entities/transaction.dart';

abstract class TransactionRemoteDataSource {
  Future<List<Transaction>> getAllTransactions();
  Future<Transaction> getTransactionById(int id);
  Future<Transaction> addTransaction(Transaction transaction);
  Future<Transaction> updateTransactionById(int id, Transaction transaction);
  Future<String> deleteTransaction(int id);
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final String baseUrl = ApiConfig.transactions();

  @override
  Future<List<Transaction>> getAllTransactions() async {
    final response =
        await http.get(Uri.parse(baseUrl)).timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as List<dynamic>;
      return data.map((e) => TransactionModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  @override
  Future<Transaction> getTransactionById(int id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$id'))
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return TransactionModel.fromJson(data);
    } else {
      throw Exception('Failed to load transaction');
    }
  }

  @override
  Future<Transaction> addTransaction(Transaction transaction) async {
    final requestBody = TransactionModel.fromEntity(transaction).toJson();

    final response = await http
        .post(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.created) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return TransactionModel.fromJson(data);
    } else {
      throw Exception('Failed to create new transaction');
    }
  }

  @override
  Future<Transaction> updateTransactionById(
      int id, Transaction transaction) async {
    final requestBody = TransactionModel.fromEntity(transaction).toJson();

    final response = await http
        .patch(
          Uri.parse('$baseUrl/$id'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return TransactionModel.fromJson(data);
    } else {
      throw Exception('Failed to update transaction');
    }
  }

  @override
  Future<String> deleteTransaction(int id) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/$id'))
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      return decoded['message'];
    } else {
      throw Exception('Failed to delete transaction');
    }
  }
}
