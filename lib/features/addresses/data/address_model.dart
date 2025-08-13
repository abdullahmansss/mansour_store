class AddressModel {
  final int id;
  final String type;
  final String firstName;
  final String lastName;
  final String fullName;
  final String? phone;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String fullAddress;
  final bool isDefault;
  final String createdAt;
  final String updatedAt;

  AddressModel({
    required this.id,
    required this.type,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    this.phone,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.fullAddress,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a AddressModel instance from a Map (e.g., from database query)
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as int,
      type: map['type'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      fullName: map['full_name'] as String,
      phone: map['phone'] as String?,
      addressLine1: map['address_line_1'] as String,
      addressLine2: map['address_line_2'] as String?,
      city: map['city'] as String,
      state: map['state'] as String,
      postalCode: map['postal_code'] as String,
      country: map['country'] as String,
      fullAddress: map['full_address'] as String,
      isDefault: map['is_default'] as bool,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}