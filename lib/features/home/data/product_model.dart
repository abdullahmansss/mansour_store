class ProductModel {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String image;
  final bool isActive;
  final int sortOrder;
  final String createdAt;
  final String updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.image,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a ProductModel instance from a Map (e.g., from database query)
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      slug: map['slug'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      isActive: map['is_active'] as bool,
      sortOrder: map['sort_order'] as int,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}