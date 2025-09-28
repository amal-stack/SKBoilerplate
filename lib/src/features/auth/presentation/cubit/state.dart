sealed class AuthOperationState<T> {
  const AuthOperationState();
}

class AuthOperationInitial<T> extends AuthOperationState<T> {
  const AuthOperationInitial();
}

class AuthOperationLoading<T> extends AuthOperationState<T> {
  const AuthOperationLoading();
}

class AuthOperationSuccess<T> extends AuthOperationState<T> {
  const AuthOperationSuccess([this.data]);

  final T? data;
}

class AuthOperationFailure<T> extends AuthOperationState<T> {
  const AuthOperationFailure(this.message);

  final String message;
}
