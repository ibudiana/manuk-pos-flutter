part of 'customer_bloc.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

class CustomerStateEmpty extends CustomerState {}

class CustomerStateLoading extends CustomerState {}

class CustomerStateError extends CustomerState {
  final String message;

  const CustomerStateError(this.message);

  @override
  List<Object> get props => [message];
}

class CustomerStateLoaded extends CustomerState {
  final List<Customer> customers;

  const CustomerStateLoaded(this.customers);

  @override
  List<Object> get props => [customers];
}

class CustomerStateLoadedById extends CustomerState {
  final Customer customer;

  const CustomerStateLoadedById(this.customer);

  @override
  List<Object> get props => [customer];
}

class CustomerDeleteSuccess extends CustomerState {
  final String message;

  const CustomerDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class CustomerOperationSuccess extends CustomerState {
  final String message;

  const CustomerOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class CustomerOperationFailure extends CustomerState {
  final String message;

  const CustomerOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
