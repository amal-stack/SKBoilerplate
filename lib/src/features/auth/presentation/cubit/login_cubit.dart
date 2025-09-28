import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/authentication.dart';
import '../../domain/repositories/auth_repository.dart';

class LoginCubit extends Cubit<Authentication> {
  LoginCubit(this._repository) : super(const Authentication.unknown()) {
    _authSubscription = _repository.state.listen(emit);
  }
  final AuthRepository _repository;

  StreamSubscription<Authentication>? _authSubscription;

  Future<void> login(String email, String password) async {
    await _repository.login(email, password);
  }

  Future<void> logout() async {
    await _repository.logout();
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
