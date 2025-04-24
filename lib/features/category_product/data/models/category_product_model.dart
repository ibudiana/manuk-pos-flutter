import 'package:manuk_pos/features/category_product/domain/entities/category_product_.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    super.parentId,
    required super.name,
    required super.code,
    required super.description,
    required super.level,
    required super.path,
    required super.createdAt,
    required super.updatedAt,
    super.parent,
    super.children,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      parentId: json['parent_id'],
      name: json['name'],
      code: json['code'],
      description: json['description'] ?? '',
      level: json['level'],
      path: json['path'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      parent: json['parent'] != null
          ? CategoryModel.fromJson(json['parent'])
          : null,
      children: json['children'] != null
          ? List<Category>.from(
              json['children'].map((child) => CategoryModel.fromJson(child)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'name': name,
      'code': code,
      'description': description,
      'level': level,
      'path': path,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'parent': parent,
      'children': children,
    };
  }
}
