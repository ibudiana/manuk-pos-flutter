import 'package:equatable/equatable.dart';

class Role extends Equatable {
  final int id;
  final String roleName;
  final String description;

  const Role({
    required this.id,
    required this.roleName,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        roleName,
        description,
      ];
}
