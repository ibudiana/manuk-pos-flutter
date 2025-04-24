import 'package:equatable/equatable.dart';

class Loan extends Equatable {
  final int id;
  final int customerId;
  final double loanAmount;
  final double interestRate;
  final int loanTerm;
  final double installmentAmount;
  final double remainingAmount;
  final DateTime startDate;
  final DateTime dueDate;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Loan({
    required this.id,
    required this.customerId,
    required this.loanAmount,
    required this.interestRate,
    required this.loanTerm,
    required this.installmentAmount,
    required this.remainingAmount,
    required this.startDate,
    required this.dueDate,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        customerId,
        loanAmount,
        interestRate,
        loanTerm,
        installmentAmount,
        remainingAmount,
        startDate,
        dueDate,
        status,
        notes,
        createdAt,
        updatedAt,
      ];
}
