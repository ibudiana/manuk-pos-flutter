import 'package:equatable/equatable.dart';

class Tax extends Equatable {
  final int id;
  final String name;
  final int rate;
  final bool isDefault;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Tax({
    required this.id,
    required this.name,
    required this.rate,
    required this.isDefault,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        rate,
        isDefault,
        isActive,
        createdAt,
        updatedAt,
      ];
}
