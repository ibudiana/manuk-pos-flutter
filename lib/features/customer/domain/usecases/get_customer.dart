import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/customer/domain/entities/customer.dart';
import 'package:manuk_pos/features/customer/domain/repositories/customer_repository.dart';

class GetCustomerById {
  final CustomerRepository customerRepository;

  GetCustomerById(this.customerRepository);

  Future<Either<Failures, Customer>> call(int id) async {
    return await customerRepository.getCustomerById(id);
  }
}
