import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/customer/domain/entities/customer.dart';
import 'package:manuk_pos/features/customer/domain/usecases/add_customer.dart';
import 'package:manuk_pos/features/customer/domain/usecases/delete_customer.dart';
import 'package:manuk_pos/features/customer/domain/usecases/get_all_customer.dart';
import 'package:manuk_pos/features/customer/domain/usecases/get_customer.dart';
import 'package:manuk_pos/features/customer/domain/usecases/update_customer.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final GetAllCustomer getAllCustomer;
  final GetCustomerById getCustomerById;
  final UpdateCustomerById updateCustomerById;
  final AddCustomer addCustomer;
  final DeleteCustomer deleteCustomer;

  CustomerBloc(
    this.getAllCustomer,
    this.updateCustomerById,
    this.getCustomerById,
    this.addCustomer,
    this.deleteCustomer,
  ) : super(CustomerStateEmpty()) {
    on<GetAllCustomerEvent>(_onGetAllCustomer);
    on<GetCustomerByIdEvent>(_onGetCustomerById);
    on<UpdateCustomerEvent>(_onUpdateCustomerById);
    on<AddCustomerEvent>(_onAddCustomer);
    on<DeleteCustomerEvent>(_onDeleteCustomer);
  }

  void _onGetAllCustomer(
      GetAllCustomerEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerStateLoading());
    Either<Failures, List<Customer>> result = await getAllCustomer.call();
    result.fold(
      (failure) => emit(
          CustomerStateError("Failed to load customers: ${failure.message}")),
      (customers) => emit(CustomerStateLoaded(customers)),
    );
  }

  void _onGetCustomerById(
      GetCustomerByIdEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerStateLoading());
    Either<Failures, Customer> result =
        await getCustomerById.call(event.customerId);
    result.fold(
      (failure) => emit(
          CustomerStateError("Failed to load customer: ${failure.message}")),
      (customer) => emit(CustomerStateLoadedById(customer)),
    );
  }

  void _onUpdateCustomerById(
      UpdateCustomerEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerStateLoading());
    Either<Failures, Customer> result =
        await updateCustomerById.call(event.customerId, event.customer);
    result.fold(
      (failure) => emit(CustomerOperationFailure(
          "Customer update failed: ${failure.message}")),
      (customer) {
        emit(CustomerOperationSuccess("Customer updated successfully"));
        add(GetAllCustomerEvent());
      },
    );
  }

  void _onAddCustomer(
      AddCustomerEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerStateLoading());
    Either<Failures, Customer> result = await addCustomer.call(event.customer);
    result.fold(
      (failure) => emit(CustomerOperationFailure(
          "Customer creation failed: ${failure.message}")),
      (customer) =>
          emit(CustomerOperationSuccess("Customer created successfully")),
    );
  }

  void _onDeleteCustomer(
      DeleteCustomerEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerStateLoading());
    Either<Failures, String> result =
        await deleteCustomer.call(event.customerId);
    result.fold(
      (failure) => emit(CustomerOperationFailure(
          "Customer deletion failed: ${failure.message}")),
      (message) {
        emit(CustomerOperationSuccess("Customer deleted successfully"));
        add(GetAllCustomerEvent());
      },
    );
  }
}
