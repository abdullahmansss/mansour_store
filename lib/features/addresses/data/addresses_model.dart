import 'package:mansour_store/core/models/base_model.dart';
import 'package:mansour_store/features/addresses/data/address_model.dart';

class AddressesModel extends BaseModel {
  final List<AddressModel> addresses;

  AddressesModel({
    required super.success,
    required this.addresses,
    super.message,
  });

  // Create a AddressesModel instance from a Map (e.g., from database query)
  factory AddressesModel.fromMap(Map<String, dynamic> map) {
    return AddressesModel(
      success: map['success'] as bool,
      addresses: (map['data'] as List<dynamic>)
          .map((address) => AddressModel.fromMap(address as Map<String, dynamic>))
          .toList(),
    );
  }
}