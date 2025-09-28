import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/utils/app_routes.dart';
import '../cubit/forgot_password_cubit.dart';
import '../widgets/auth_bloc_listener.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/forgot_password_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => ForgotPasswordCubit(context.read()),
    child: AuthBlocListener<ForgotPasswordCubit, ForgotPasswordDetails>(
      onSuccess: (context, data) {
        if (data != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(data.message)));

          context.go(AppRoutes.resetPassword, extra: data.email);
        }
      },
      child: const AuthScaffold(child: ForgotPasswordForm()),
    ),
  );
}
