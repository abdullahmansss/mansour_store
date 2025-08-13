class LoginUserModel {
  final int id;
  final String name;
  final String email;
  final String phone;

  LoginUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  // Create a LoginUserModel instance from a Map (e.g., from database query)
  factory LoginUserModel.fromMap(Map<String, dynamic> map) {
    return LoginUserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
    );
  }
}









