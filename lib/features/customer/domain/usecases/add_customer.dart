import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/customer/domain/entities/customer.dart';
import 'package:manuk_pos/features/customer/domain/repositories/customer_repository.dart';

class AddCustomer {
  final CustomerRepository customerRepository;

  AddCustomer(this.customerRepository);

  Future<Either<Failures, Customer>> call(Customer customer) async {
    return await customerRepository.addCustomer(customer);
  }
}
