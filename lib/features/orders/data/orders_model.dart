import 'package:mansour_store/features/orders/data/order_model.dart';

class OrdersModel {
  final bool success;
  final List<OrderModel> data;

  OrdersModel({
    required this.success,
    required this.data,
  });

  // Create a OrdersModel instance from a Map (e.g., from database query)
  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return OrdersModel(
      success: map['success'] as bool,
      data: List<OrderModel>.from(
        (map['data'] as List<dynamic>).map<OrderModel>(
          (item) => OrderModel.fromMap(item as Map<String, dynamic>),
        ),
      ),
    );
  }
}