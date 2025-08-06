import 'package:mansour_store/core/models/product_model.dart';

class ProductDetailsModel {
  final bool success;
  final ProductModel product;

  ProductDetailsModel({
    required this.success,
    required this.product,
  });

  // Create a ProductDetailsModel instance from a Map (e.g., from database query)
  factory ProductDetailsModel.fromMap(Map<String, dynamic> map) {
    return ProductDetailsModel(
      success: map['success'] as bool,
      product: ProductModel.fromMap(
        map['data'] as Map<String, dynamic>,
      ),
    );
  }
}