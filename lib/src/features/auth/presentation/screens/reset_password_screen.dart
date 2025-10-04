import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/utils/app_routes.dart';
import '../cubit/reset_password_cubit.dart';
import '../widgets/auth_bloc_listener.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/reset_password_form.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => ResetPasswordCubit(context.read()),
    child: AuthBlocListener<ResetPasswordCubit, String>(
      onSuccess: (context, data) {
        if (data != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(data)));
          context.go(AppRoutes.authSuccess);
        }
      },
      child: AuthScaffold(child: ResetPasswordForm(email: email)),
    ),
  );
}
