import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/loan/domain/repositories/loan_repository.dart';

class DeleteLoan {
  final LoanRepository loanRepository;

  DeleteLoan(this.loanRepository);

  Future<Either<Failures, String>> call(int id) async {
    return await loanRepository.deleteLoan(id);
  }
}
