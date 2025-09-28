import '../../../core/network/api_client.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<Map<String, dynamic>> login(String email, String password) async {
    return await _apiClient.post("/login", {
      "email": email,
      "password": password,
    });
  }
}
