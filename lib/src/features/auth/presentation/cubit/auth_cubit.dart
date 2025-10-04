import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/authentication_result.dart';
import 'state.dart';

class AuthCubit<T> extends Cubit<AuthOperationState<T>> {
  AuthCubit([AuthOperationState<T>? initialState])
    : super(initialState ?? AuthOperationInitial<T>());

  void initial() => emit(AuthOperationInitial<T>());

  void loading() => emit(AuthOperationLoading<T>());

  void success([T? data]) => emit(AuthOperationSuccess(data));

  void failure(String message) => emit(AuthOperationFailure(message));

  static AuthOperationState<String> stateWithMessageFromResult(
    AuthenticationResult<Object?> result,
  ) => switch (result) {
    AuthenticationResult(isSuccess: true, message: final message) =>
      AuthOperationSuccess(message),
    AuthenticationResult(isSuccess: false, message: final message) =>
      AuthOperationFailure(message),
  };
}
