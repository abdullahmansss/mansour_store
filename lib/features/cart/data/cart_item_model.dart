import 'package:mansour_store/core/models/product_model.dart';

class CartItemModel {
  final int id;
  final int cartId;
  final int productId;
  final int quantity;
  final num subtotal;
  final ProductModel product;
  final String createdAt;
  final String updatedAt;

  CartItemModel({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.subtotal,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a CartItemModel instance from a Map (e.g., from database query)
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as int,
      cartId: map['cart_id'] as int,
      productId: map['product_id'] as int,
      quantity: map['quantity'] as int,
      subtotal: map['subtotal'] as num,
      product: ProductModel.fromMap(map['product'] as Map<String, dynamic>),
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}