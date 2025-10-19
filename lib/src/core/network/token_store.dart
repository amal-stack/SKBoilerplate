import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class TokenStore {
  Future<String?> token();

  Future<void> saveToken(String token);

  Future<void> clearToken();
}

class InMemoryTokenStore implements TokenStore {
  String? _token;

  @override
  Future<String?> token() async => _token;

  @override
  Future<void> saveToken(String token) async {
    _token = token;
  }

  @override
  Future<void> clearToken() async {
    _token = null;
  }
}

class SecureTokenStore implements TokenStore {
  const SecureTokenStore(this.key, [FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  final String key;

  final FlutterSecureStorage _storage;

  @override
  Future<String?> token() => _storage.read(key: key);

  @override
  Future<void> saveToken(String token) =>
      _storage.write(key: key, value: token);

  @override
  Future<void> clearToken() => _storage.delete(key: key);
}
