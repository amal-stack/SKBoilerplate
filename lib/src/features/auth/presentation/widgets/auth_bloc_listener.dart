import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/state.dart';

class AuthBlocListener<B extends BlocBase<AuthOperationState<T>>, T>
    extends StatelessWidget {
  const AuthBlocListener({
    super.key,
    this.bloc,
    required this.child,
    this.onSuccess,
    this.onFailure,
  });

  final Widget child;

  final B? bloc;

  final void Function(BuildContext context, T? data)? onSuccess;

  final void Function(BuildContext context, String message)? onFailure;

  @override
  Widget build(BuildContext context) => BlocListener<B, AuthOperationState<T>>(
    bloc: bloc,
    listener: (context, state) {
      switch (state) {
        case AuthOperationSuccess<T>(:final data):
          onSuccess?.call(context, data);
        case AuthOperationFailure<T>(:final message):
          if (onFailure != null) {
            onFailure?.call(context, message);
            return;
          }
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        default:
        // No action needed for other states
      }
    },
    child: child,
  );
}
