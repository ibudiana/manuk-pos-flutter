import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/loan/domain/entities/loan.dart';
import 'package:manuk_pos/features/loan/domain/repositories/loan_repository.dart';

class GetAllLoan {
  final LoanRepository loanRepository;

  GetAllLoan(this.loanRepository);

  Future<Either<Failures, List<Loan>>> call() async {
    return await loanRepository.getAllLoans();
  }
}
