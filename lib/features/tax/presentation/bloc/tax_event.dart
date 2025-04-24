part of 'tax_bloc.dart';

abstract class TaxEvent extends Equatable {
  const TaxEvent();

  @override
  List<Object> get props => [];
}

class GetAllTaxEvent extends TaxEvent {
  const GetAllTaxEvent();

  @override
  List<Object> get props => [];
}

class GetTaxByIdEvent extends TaxEvent {
  final int taxId;

  const GetTaxByIdEvent(this.taxId);

  @override
  List<Object> get props => [taxId];
}

class AddTaxEvent extends TaxEvent {
  final Tax tax;

  const AddTaxEvent(this.tax);

  @override
  List<Object> get props => [tax];
}

class UpdateTaxEvent extends TaxEvent {
  final int taxId;
  final Tax tax;

  const UpdateTaxEvent(this.taxId, this.tax);

  @override
  List<Object> get props => [taxId, tax];
}

class DeleteTaxEvent extends TaxEvent {
  final int taxId;

  const DeleteTaxEvent(this.taxId);

  @override
  List<Object> get props => [taxId];
}
