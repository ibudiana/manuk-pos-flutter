import 'package:manuk_pos/features/loan/domain/entities/loan.dart';

class LoanModel extends Loan {
  const LoanModel({
    required super.id,
    required super.customerId,
    required super.loanAmount,
    required super.interestRate,
    required super.loanTerm,
    required super.installmentAmount,
    required super.remainingAmount,
    required super.startDate,
    required super.dueDate,
    required super.status,
    super.notes,
    required super.createdAt,
    required super.updatedAt,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['id'],
      customerId: json['customer_id'],
      loanAmount: json['loan_amount'].toDouble(),
      interestRate: json['interest_rate'].toDouble(),
      loanTerm: json['loan_term'],
      installmentAmount: json['installment_amount'].toDouble(),
      remainingAmount: json['remaining_amount'].toDouble(),
      startDate: DateTime.parse(json['start_date']),
      dueDate: DateTime.parse(json['due_date']),
      status: json['status'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'loan_amount': loanAmount,
      'interest_rate': interestRate,
      'loan_term': loanTerm,
      'installment_amount': installmentAmount,
      'remaining_amount': remainingAmount,
      'start_date': startDate.toIso8601String(),
      'due_date': dueDate.toIso8601String(),
      'status': status,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
