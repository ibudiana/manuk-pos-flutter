part of 'fee_bloc.dart';

abstract class FeeEvent extends Equatable {
  const FeeEvent();

  @override
  List<Object> get props => [];
}

class GetAllFeeEvent extends FeeEvent {
  const GetAllFeeEvent();

  @override
  List<Object> get props => [];
}

class GetFeeByIdEvent extends FeeEvent {
  final int feeId;

  const GetFeeByIdEvent(this.feeId);

  @override
  List<Object> get props => [feeId];
}

class AddFeeEvent extends FeeEvent {
  final Fee fee;

  const AddFeeEvent(this.fee);

  @override
  List<Object> get props => [fee];
}

class UpdateFeeEvent extends FeeEvent {
  final int feeId;
  final Fee fee;

  const UpdateFeeEvent(this.feeId, this.fee);

  @override
  List<Object> get props => [feeId, fee];
}

class DeleteFeeEvent extends FeeEvent {
  final int feeId;

  const DeleteFeeEvent(this.feeId);

  @override
  List<Object> get props => [feeId];
}
