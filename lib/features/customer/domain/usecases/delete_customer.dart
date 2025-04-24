import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/customer/domain/repositories/customer_repository.dart';

class DeleteCustomer {
  final CustomerRepository customerRepository;

  DeleteCustomer(this.customerRepository);

  Future<Either<Failures, String>> call(int id) async {
    return await customerRepository.deleteCustomer(id);
  }
}
