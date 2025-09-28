import 'dart:async';

class ApiClient {
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    await Future.delayed(const Duration(seconds: 2));

    if (endpoint == "/login") {
      if (body["email"] == "demo@gmail.com" && body["password"] == "12345678") {
        return {
          "success": true,
          "token": "fake_jwt_token_123",
          "user": {
            "id": 1,
            "email": "demo@gmail.com",
            "name": "Demo User",
          }
        };
      } else {
        throw Exception("Invalid credentials");
      }
    }
    throw Exception("Unknown endpoint");
  }
}
