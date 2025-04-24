import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/loan/domain/entities/loan.dart';
import 'package:manuk_pos/features/loan/domain/repositories/loan_repository.dart';

class GetLoanById {
  final LoanRepository loanRepository;

  GetLoanById(this.loanRepository);

  Future<Either<Failures, Loan>> call(int id) async {
    return await loanRepository.getLoanById(id);
  }
}
