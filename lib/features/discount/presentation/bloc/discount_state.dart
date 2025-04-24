part of 'discount_bloc.dart';

abstract class DiscountState extends Equatable {
  const DiscountState();

  @override
  List<Object> get props => [];
}

class DiscountStateEmpty extends DiscountState {}

class DiscountStateLoading extends DiscountState {}

class DiscountStateError extends DiscountState {
  final String message;

  const DiscountStateError(this.message);

  @override
  List<Object> get props => [message];
}

class DiscountStateLoaded extends DiscountState {
  final List<Discount> discounts;

  const DiscountStateLoaded(this.discounts);

  @override
  List<Object> get props => [discounts];
}

class DiscountStateLoadedById extends DiscountState {
  final Discount discount;

  const DiscountStateLoadedById(this.discount);

  @override
  List<Object> get props => [discount];
}

class DiscountDeleteSuccess extends DiscountState {
  final String message;

  const DiscountDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class DiscountOperationSuccess extends DiscountState {
  final String message;

  const DiscountOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class DiscountOperationFailure extends DiscountState {
  final String message;

  const DiscountOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
