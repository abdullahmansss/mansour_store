class BaseModel {
  final bool success;
  final String? message;

  BaseModel({
    required this.success,
    this.message,
  });

  // Create a BaseModel instance from a Map (e.g., from database query)
  factory BaseModel.fromMap(Map<String, dynamic> map) {
    return BaseModel(
      success: map['success'] as bool,
      message: map['message'] as String,
    );
  }
}









