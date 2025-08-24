class OrderModel {
  final int id;
  final String orderNumber;
  final String status;
  final String subtotal;
  final String taxAmount;
  final String shippingAmount;
  final String totalAmount;
  final String currency;
  final String paymentMethod;
  final String paymentStatus;
  final String? notes;
  final int totalItems;
  final bool canBeCancelled;
  final String createdAt;
  final String updatedAt;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.subtotal,
    required this.taxAmount,
    required this.shippingAmount,
    required this.totalAmount,
    required this.currency,
    required this.paymentMethod,
    required this.paymentStatus,
    this.notes,
    required this.totalItems,
    required this.canBeCancelled,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a OrderModel instance from a Map (e.g., from database query)
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as int,
      orderNumber: map['order_number'] as String,
      status: map['status'] as String,
      subtotal: map['subtotal'] as String,
      taxAmount: map['tax_amount'] as String,
      shippingAmount: map['shipping_amount'] as String,
      totalAmount: map['total_amount'] as String,
      currency: map['currency'] as String,
      paymentMethod: map['payment_method'] as String,
      paymentStatus: map['payment_status'] as String,
      notes: map['notes'] as String?,
      totalItems: map['total_items'] as int,
      canBeCancelled: map['can_be_cancelled'] as bool,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}