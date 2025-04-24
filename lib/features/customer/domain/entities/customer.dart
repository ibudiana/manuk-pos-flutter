import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final int id;
  final int taxId;
  final String code;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String city;
  final String postalCode;
  final DateTime birthdate;
  final DateTime joinDate;
  final String customerType;
  final double creditLimit;
  final double currentBalance;
  final bool isActive;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Customer({
    required this.id,
    required this.taxId,
    required this.code,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.birthdate,
    required this.joinDate,
    required this.customerType,
    required this.creditLimit,
    required this.currentBalance,
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
        phone,
        email,
        address,
        city,
        postalCode,
        birthdate,
        joinDate,
        customerType,
        creditLimit,
        currentBalance,
        isActive,
        notes,
        createdAt,
        updatedAt,
      ];
}
