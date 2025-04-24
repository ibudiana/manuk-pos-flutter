import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/customer/domain/entities/customer.dart';
import 'package:manuk_pos/features/customer/domain/repositories/customer_repository.dart';

class UpdateCustomerById {
  final CustomerRepository customerRepository;

  UpdateCustomerById(this.customerRepository);

  Future<Either<Failures, Customer>> call(int id, Customer customer) async {
    return await customerRepository.updateCustomerById(id, customer);
  }
}
