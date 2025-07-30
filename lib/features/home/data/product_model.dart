class ProductModel {
  final int id;
  final String? name;
  final String? slug;
  final String? description;
  final String? shortDescription;
  final String? sku;
  final String? price;
  final String? salePrice;
  final String? effectivePrice;
  final bool? isOnSale;
  final int? stockQuantity;
  // final bool? inStock;
  final String? image;
  final String? weight;
  final String? length;
  final String? width;
  final String? height;
  final String? createdAt;
  final String? updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.price,
    required this.salePrice,
    required this.effectivePrice,
    required this.isOnSale,
    required this.stockQuantity,
    // required this.inStock,
    required this.image,
    required this.weight,
    required this.length,
    required this.width,
    required this.height,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a ProductModel instance from a Map (e.g., from database query)
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String?,
      slug: map['slug'] as String?,
      description: map['description'] as String?,
      shortDescription: map['short_description'] as String?,
      sku: map['sku'] as String?,
      price: map['price'] as String?,
      salePrice: map['sale_price'] as String?,
      effectivePrice: map['effective_price'] as String?,
      isOnSale: map['is_on_sale'] as bool?,
      stockQuantity: map['stock_quantity'] as int?,
      // inStock: map['in_stock'] as bool?,
      image: map['image'] as String?,
      weight: map['weight'] as String?,
      length: map['dimensions'] != null ? (map['dimensions']['length'] as String?) : '0',
      width: map['dimensions'] != null ? (map['dimensions']['width'] as String?) : '0',
      height: map['dimensions'] != null ? (map['dimensions']['height'] as String?) : '0',
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }
}









