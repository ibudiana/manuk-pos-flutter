import 'dart:convert';
import 'dart:io';
import 'package:manuk_pos/core/config/api_config.dart';
import 'package:manuk_pos/features/loan/data/models/loan_model.dart';
import 'package:manuk_pos/features/loan/domain/entities/loan.dart';
import 'package:http/http.dart' as http;

abstract class LoanRemoteDataSource {
  Future<List<Loan>> getAllLoans();
  Future<Loan> getLoanById(int id);
  Future<Loan> addLoan(Loan loan);
  Future<Loan> updateLoanById(int id, Loan loan);
  Future<String> deleteLoan(int id);
}

class LoanRemoteDataSourceImpl implements LoanRemoteDataSource {
  final String baseUrl = ApiConfig.loans();

  @override
  Future<List<Loan>> getAllLoans() async {
    final response =
        await http.get(Uri.parse(baseUrl)).timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as List<dynamic>;
      return data.map((e) => LoanModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load loans');
    }
  }

  @override
  Future<Loan> getLoanById(int id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$id'))
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return LoanModel.fromJson(data);
    } else {
      throw Exception('Failed to load loan');
    }
  }

  @override
  Future<Loan> addLoan(Loan loan) async {
    final newLoanData = {
      'customer_id': loan.customerId,
      'loan_amount': loan.loanAmount,
      'interest_rate': loan.interestRate,
      'loan_term': loan.loanTerm,
      'installment_amount': loan.installmentAmount,
      'remaining_amount': loan.remainingAmount,
      'start_date': loan.startDate.toIso8601String(),
      'due_date': loan.dueDate.toIso8601String(),
      'status': loan.status,
      'notes': loan.notes,
    };

    final response = await http
        .post(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newLoanData),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.created) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return LoanModel.fromJson(data);
    } else {
      throw Exception('Failed to create new loan');
    }
  }

  @override
  Future<Loan> updateLoanById(int id, Loan loan) async {
    final updatedData = {
      'customer_id': loan.customerId,
      'loan_amount': loan.loanAmount,
      'interest_rate': loan.interestRate,
      'loan_term': loan.loanTerm,
      'installment_amount': loan.installmentAmount,
      'remaining_amount': loan.remainingAmount,
      'start_date': loan.startDate.toIso8601String(),
      'due_date': loan.dueDate.toIso8601String(),
      'status': loan.status,
      'notes': loan.notes,
    };

    final response = await http
        .patch(
          Uri.parse('$baseUrl/$id'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(updatedData),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      return LoanModel.fromJson(data);
    } else {
      throw Exception('Failed to update loan');
    }
  }

  @override
  Future<String> deleteLoan(int id) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/$id'))
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == HttpStatus.ok) {
      final decoded = json.decode(response.body);
      return decoded['message'];
    } else {
      throw Exception('Failed to delete loan');
    }
  }
}
