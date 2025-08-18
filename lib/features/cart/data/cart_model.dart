import 'package:mansour_store/core/models/base_model.dart';
import 'package:mansour_store/features/cart/data/cart_item_model.dart';

class CartModel extends BaseModel {
  final CartDataModel data;

  CartModel({
    required super.success,
    super.message,
    required this.data,
  });

  // Create a CartModel instance from a Map (e.g., from database query)
  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      success: map['success'] as bool,
      message: map['message'] as String?,
      data: CartDataModel.fromMap(map['data'] as Map<String, dynamic>),
    );
  }
}

class CartDataModel {
  final int id;
  final List<CartItemModel> items;
  final int itemsCount;
  final num total;
  final String createdAt;
  final String updatedAt;

  CartDataModel({
    required this.id,
    required this.items,
    required this.itemsCount,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a CartDataModel instance from a Map (e.g., from database query)
  factory CartDataModel.fromMap(Map<String, dynamic> map) {
    return CartDataModel(
      id: map['id'] as int,
      items: (map['items'] as List<dynamic>)
          .map((item) => CartItemModel.fromMap(item as Map<String, dynamic>))
          .toList(),
      itemsCount: map['items_count'] as int,
      total: map['total'] as num,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}