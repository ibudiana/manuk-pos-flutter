import 'package:equatable/equatable.dart';

class Fee extends Equatable {
  final int id;
  final String name;
  final String feeType;
  final double feeValue;
  final bool isDefault;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Fee({
    required this.id,
    required this.name,
    required this.feeType,
    required this.feeValue,
    required this.isDefault,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        feeType,
        feeValue,
        isDefault,
        isActive,
        createdAt,
        updatedAt,
      ];
}
