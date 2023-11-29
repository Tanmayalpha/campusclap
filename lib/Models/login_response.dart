class LoginResponse {
  final bool status;
  final dynamic message; // Use dynamic for flexibility
  final Map<String, dynamic> data;

  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] ?? {},
    );
  }
}