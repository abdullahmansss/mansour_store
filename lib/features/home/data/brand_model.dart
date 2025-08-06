class BrandModel {
  final int id;
  final String name;
  final String slug;
  final String? description;
  final String logo;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  BrandModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.logo,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a BrandModel instance from a Map (e.g., from database query)
  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: map['id'] as int,
      name: map['name'] as String,
      slug: map['slug'] as String,
      description: map['description'] as String?,
      logo: map['logo'] as String,
      isActive: map['is_active'] as bool,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}