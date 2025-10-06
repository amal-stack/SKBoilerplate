import 'dart:async';
import 'package:boilerplate/src/features/auth/domain/entities/authentication.dart';
import 'package:boilerplate/src/features/auth/presentation/cubit/login_cubit.dart';
import 'package:boilerplate/src/features/auth/presentation/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Navigate after 3 seconds
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        final auth = context.read<LoginCubit>().state;

        if (auth case AuthOperationSuccess(:final data)) {
          if (data is Authenticated) {
            context.go('/dashboard');
          }
        }

        context.go('/introslider-screen');
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/app_splash.png"),
            fit: BoxFit.cover,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/app_name_logo.png",
              width: 255.w,
              height: 55.h,
            ),
          ],
        ),
      ),
    );
  }
}
