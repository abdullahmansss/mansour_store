import 'package:mansour_store/features/home/data/category_model.dart';

class CategoriesModel {
  final bool success;
  final List<CategoryModel> categories;

  CategoriesModel({
    required this.success,
    required this.categories,
  });

  // Create a CategoriesModel instance from a Map (e.g., from database query)
  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    return CategoriesModel(
      success: map['success'] as bool,
      categories: (map['data'] as List<dynamic>)
          .map((category) => CategoryModel.fromMap(category as Map<String, dynamic>))
          .toList(),
    );
  }
}