part of 'discount_bloc.dart';

abstract class DiscountEvent extends Equatable {
  const DiscountEvent();

  @override
  List<Object> get props => [];
}

class GetAllDiscountEvent extends DiscountEvent {
  const GetAllDiscountEvent();

  @override
  List<Object> get props => [];
}

class GetDiscountByIdEvent extends DiscountEvent {
  final int discountId;

  const GetDiscountByIdEvent(this.discountId);

  @override
  List<Object> get props => [discountId];
}

class AddDiscountEvent extends DiscountEvent {
  final Discount discount;
  const AddDiscountEvent(this.discount);

  @override
  List<Object> get props => [discount];
}

class UpdateDiscountEvent extends DiscountEvent {
  final Discount discount;
  final int discountId;

  const UpdateDiscountEvent(this.discountId, this.discount);

  @override
  List<Object> get props => [discountId, discount];
}

class DeleteDiscountEvent extends DiscountEvent {
  final int discountId;

  const DeleteDiscountEvent(this.discountId);

  @override
  List<Object> get props => [discountId];
}
