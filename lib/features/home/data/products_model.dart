import 'package:mansour_store/core/models/product_model.dart';

class ProductsModel {
  final bool success;
  final List<ProductModel> products;

  ProductsModel({
    required this.success,
    required this.products,
  });

  // Create a ProductsModel instance from a Map (e.g., from database query)
  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      success: map['success'] as bool,
      products: (map['data']['products'] as List<dynamic>)
          .map((category) => ProductModel.fromMap(category as Map<String, dynamic>))
          .toList(),
    );
  }
}