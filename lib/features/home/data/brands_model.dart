import 'package:mansour_store/features/home/data/brand_model.dart';

class BrandsModel {
  final bool success;
  final List<BrandModel> brands;

  BrandsModel({
    required this.success,
    required this.brands,
  });

  // Create a BrandsModel instance from a Map (e.g., from database query)
  factory BrandsModel.fromMap(Map<String, dynamic> map) {
    return BrandsModel(
      success: map['success'] as bool,
      brands: (map['data'] as List<dynamic>)
          .map((category) => BrandModel.fromMap(category as Map<String, dynamic>))
          .toList(),
    );
  }
}