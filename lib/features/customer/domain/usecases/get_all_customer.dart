import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/customer/domain/entities/customer.dart';
import 'package:manuk_pos/features/customer/domain/repositories/customer_repository.dart';

class GetAllCustomer {
  final CustomerRepository customerRepository;

  GetAllCustomer(this.customerRepository);

  Future<Either<Failures, List<Customer>>> call() async {
    return await customerRepository.getAllCustomer();
  }
}
