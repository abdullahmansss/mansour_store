import 'package:mansour_store/features/login/data/login_user_model.dart';

class LoginModel {
  final bool success;
  final LoginUserModel user;
  final String token;

  LoginModel({
    required this.success,
    required this.user,
    required this.token,
  });

  // Create a LoginModel instance from a Map (e.g., from database query)
  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      success: map['success'] as bool,
      user: LoginUserModel.fromMap(map['user'] as Map<String, dynamic>),
      token: map['token'] as String,
    );
  }
}














