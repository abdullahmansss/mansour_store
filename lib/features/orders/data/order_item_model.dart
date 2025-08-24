class OrderItemModel {
  final int id;
  final int productId;
  final int quantity;
  final String price;
  final String total;

  OrderItemModel({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.total,
  });

  // Create a OrderItemModel instance from a Map (e.g., from database query)
  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map['id'] as int,
      productId: map['product_id'] as int,
      quantity: map['quantity'] as int,
      price: map['price'] as String,
      total: map['total'] as String,
    );
  }
}