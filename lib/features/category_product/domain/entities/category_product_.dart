import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final int? parentId;
  final String name;
  final String code;
  final String description;
  final int level;
  final String path;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Category? parent;
  final List<Category>? children;

  const Category({
    required this.id,
    this.parentId,
    required this.name,
    required this.code,
    required this.description,
    required this.level,
    required this.path,
    required this.createdAt,
    required this.updatedAt,
    this.parent,
    this.children,
  });

  @override
  List<Object?> get props => [
        id,
        parentId,
        name,
        code,
        description,
        level,
        path,
        createdAt,
        updatedAt,
        parent,
        children,
      ];
}
