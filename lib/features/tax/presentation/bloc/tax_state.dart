part of 'tax_bloc.dart';

abstract class TaxState extends Equatable {
  const TaxState();

  @override
  List<Object> get props => [];
}

class TaxStateEmpty extends TaxState {}

class TaxStateLoading extends TaxState {}

class TaxStateError extends TaxState {
  final String message;

  const TaxStateError(this.message);

  @override
  List<Object> get props => [message];
}

class TaxStateLoaded extends TaxState {
  final List<Tax> taxes;

  const TaxStateLoaded(this.taxes);

  @override
  List<Object> get props => [taxes];
}

class TaxStateLoadedById extends TaxState {
  final Tax tax;

  const TaxStateLoadedById(this.tax);

  @override
  List<Object> get props => [tax];
}

class TaxDeleteSuccess extends TaxState {
  final String message;

  const TaxDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class TaxOperationSuccess extends TaxState {
  final String message;

  const TaxOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class TaxOperationFailure extends TaxState {
  final String message;

  const TaxOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
