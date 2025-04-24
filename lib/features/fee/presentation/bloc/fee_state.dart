part of 'fee_bloc.dart';

abstract class FeeState extends Equatable {
  const FeeState();

  @override
  List<Object> get props => [];
}

class FeeStateEmpty extends FeeState {}

class FeeStateLoading extends FeeState {}

class FeeStateError extends FeeState {
  final String message;

  const FeeStateError(this.message);

  @override
  List<Object> get props => [message];
}

class FeeStateLoaded extends FeeState {
  final List<Fee> fees;

  const FeeStateLoaded(this.fees);

  @override
  List<Object> get props => [fees];
}

class FeeStateLoadedById extends FeeState {
  final Fee fee;

  const FeeStateLoadedById(this.fee);

  @override
  List<Object> get props => [fee];
}

class FeeDeleteSuccess extends FeeState {
  final String message;

  const FeeDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class FeeOperationSuccess extends FeeState {
  final String message;

  const FeeOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class FeeOperationFailure extends FeeState {
  final String message;

  const FeeOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
