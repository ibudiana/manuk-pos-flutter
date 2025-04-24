part of 'customer_bloc.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object> get props => [];
}

class GetAllCustomerEvent extends CustomerEvent {
  const GetAllCustomerEvent();

  @override
  List<Object> get props => [];
}

class GetCustomerByIdEvent extends CustomerEvent {
  final int customerId;

  const GetCustomerByIdEvent(this.customerId);

  @override
  List<Object> get props => [customerId];
}

class AddCustomerEvent extends CustomerEvent {
  final Customer customer;

  const AddCustomerEvent(this.customer);

  @override
  List<Object> get props => [customer];
}

class UpdateCustomerEvent extends CustomerEvent {
  final int customerId;
  final Customer customer;

  const UpdateCustomerEvent(this.customerId, this.customer);

  @override
  List<Object> get props => [customerId, customer];
}

class DeleteCustomerEvent extends CustomerEvent {
  final int customerId;

  const DeleteCustomerEvent(this.customerId);

  @override
  List<Object> get props => [customerId];
}
