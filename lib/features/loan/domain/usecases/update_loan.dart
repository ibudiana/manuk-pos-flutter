import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/loan/domain/entities/loan.dart';
import 'package:manuk_pos/features/loan/domain/repositories/loan_repository.dart';

class UpdateLoanById {
  final LoanRepository loanRepository;

  UpdateLoanById(this.loanRepository);

  Future<Either<Failures, Loan>> call(int id, Loan loan) async {
    return await loanRepository.updateLoanById(id, loan);
  }
}
