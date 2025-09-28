
import '../entities/user.dart';

abstract interface class UserRepository {
  Future<AppUser> userProfile();

  void dispose();
}