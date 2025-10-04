import '../../../domain/entities/user.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../data_sources/auth_source.dart';

class RemoteUserRepository implements UserRepository {
  const RemoteUserRepository(this._client);

  final AuthSource _client;

  @override
  Future<AppUser> userProfile() async {
    final response = await _client.userProfile();
    return response.data!;
  }

  @override
  void dispose() {}
}
