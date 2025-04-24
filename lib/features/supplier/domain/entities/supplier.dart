import 'package:equatable/equatable.dart';

class Supplier extends Equatable {
  final int id;
  final int taxId;
  final String code;
  final String name;
  final String contactPerson;
  final String phone;
  final String email;
  final String address;
  final int paymentTerms;
  final bool isActive;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Supplier({
    required this.id,
    required this.taxId,
    required this.code,
    required this.name,
    required this.contactPerson,
    required this.phone,
    required this.email,
    required this.address,
    required this.paymentTerms,
    required this.isActive,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        taxId,
        code,
        name,
        contactPerson,
        phone,
        email,
        address,
        paymentTerms,
        isActive,
        notes,
        createdAt,
        updatedAt,
      ];
}
