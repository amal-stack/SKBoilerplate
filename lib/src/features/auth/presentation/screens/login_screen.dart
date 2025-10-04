import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../shared/utils/app_routes.dart';
import '../../domain/entities/authentication.dart';
import '../../domain/repositories/auth_repository.dart';
import '../cubit/login_cubit.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => LoginCubit(context.read<AuthRepository>()),
    child: BlocListener<LoginCubit, Authentication>(
      listener: (context, state) {
        switch (state) {
          case Authenticated():
            // var box = Hive.box('prefs');
            // box.put('isLoggedIn', true);

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
    ),
  );
}
