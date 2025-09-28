
/// Results of an authentication operation, encapsulating success or failure states.
class AuthenticationResult<T> {
  const AuthenticationResult.success({
    this.data,
    required this.message,
  }) : isSuccess = true;

  const AuthenticationResult.failure({
    required this.message,
  }) : isSuccess = false, data = null;

  final T? data;

  final bool isSuccess;

  final String message;


}