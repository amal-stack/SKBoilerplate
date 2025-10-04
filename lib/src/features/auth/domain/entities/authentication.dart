import 'user.dart';

/// Represents the state of authentication in the application.
sealed class Authentication {
  const Authentication();

  const factory Authentication.authenticated(AppUser? user) =
      Authenticated;

  const factory Authentication.unauthenticated([
    String? message,
    Object? error,
  ]) = Unauthenticated;


  const factory Authentication.initial() = AuthenticationInitial;
}

class Authenticated extends Authentication {
  const Authenticated(this.user);

  final AppUser? user;
}

class Unauthenticated extends Authentication {
  const Unauthenticated([this.message, this.error]);

  final String? message;

  final Object? error;
}

class AuthenticationInitial extends Authentication {
  const AuthenticationInitial();
}
