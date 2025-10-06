import 'package:boilerplate/src/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:boilerplate/src/features/auth/presentation/widgets/auth_bloc_listener.dart';
import 'package:boilerplate/src/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:boilerplate/src/features/auth/presentation/widgets/otp_verification_form.dart';
import 'package:boilerplate/src/shared/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => OtpCubit(context.read()),
    child: AuthBlocListener<OtpCubit, OtpState>(
      onSuccess: (context, data) {
        if (data != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(data.message)));

          if (data case OtpVerified(:final email, :final otp)) {
            context.go(
              AppRoutes.resetPassword,
              extra: {'email': email, 'code': otp},
            );
          }
        }
      },
      child: AuthScaffold(child: OtpVerificationForm(email: email)),
    ),
  );
}
