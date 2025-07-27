import 'package:mansour_store/features/home/data/product_model.dart';

class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String image;
  final bool isActive;
  final int sortOrder;
  final List<ProductModel> products;
  final String createdAt;
  final String updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.image,
    required this.isActive,
    required this.sortOrder,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a CategoryModel instance from a Map (e.g., from database query)
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      name: map['name'] as String,
      slug: map['slug'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      isActive: map['is_active'] as bool,
      sortOrder: map['sort_order'] as int,
      products: (map['children'] as List<dynamic>)
          .map((child) => ProductModel.fromMap(child as Map<String, dynamic>))
          .toList(),
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}