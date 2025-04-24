import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/loan/domain/entities/loan.dart';
import 'package:manuk_pos/features/loan/domain/repositories/loan_repository.dart';

class AddLoan {
  final LoanRepository loanRepository;

  AddLoan(this.loanRepository);

  Future<Either<Failures, Loan>> call(Loan loan) async {
    return await loanRepository.addLoan(loan);
  }
}
