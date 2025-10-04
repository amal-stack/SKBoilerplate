import 'package:boilerplate/src/features/auth/presentation/widgets/auth_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/utils/app_routes.dart';
import '../../domain/entities/authentication.dart';
import '../cubit/login_cubit.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => AuthBlocListener<LoginCubit, Authentication>(
    onSuccess: (context, auth) {
      switch (auth) {
        case Authenticated():
          context.go(AppRoutes.dashboard);
        case Unauthenticated(message: final message):
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message ?? 'Authentication failed')),
          );
  
        default:
        // No action needed for other states
      }
    },
    child: const Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: LoginForm(),
            ),
          ),
        ),
      ),
    ),
  );
}
