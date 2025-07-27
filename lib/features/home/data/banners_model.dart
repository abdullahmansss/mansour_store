import 'package:mansour_store/features/home/data/banner_model.dart';

class BannersModel {
  final bool success;
  final List<BannerModel> banners;

  BannersModel({
    required this.success,
    required this.banners,
  });

  // Create a BannersModel instance from a Map (e.g., from database query)
  factory BannersModel.fromMap(Map<String, dynamic> map) {
    return BannersModel(
      success: map['success'] as bool,
      banners: (map['data'] as List<dynamic>)
          .map((category) => BannerModel.fromMap(category as Map<String, dynamic>))
          .toList(),
    );
  }
}