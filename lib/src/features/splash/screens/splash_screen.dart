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
  StreamSubscription<AuthOperationState<Authentication>>? _authSubscription;

  Stream<AuthOperationState<Authentication>> _delayedStream(
    Duration delay,
  ) async* {
    await Future<void>.delayed(delay);
    if (!mounted) {
      return;
    }
    final cubit = context.read<LoginCubit>();
    yield cubit.state;
    yield* cubit.stream;
  }

  @override
  void initState() {
    super.initState();
    _authSubscription = _delayedStream(const Duration(seconds: 3)).listen((
      state,
    ) {
      if (!mounted) {
        debugPrint('SplashScreen disposed');
        return;
      }
      if (state case AuthOperationSuccess(:final data)) {
        if (data is Authenticated) {
          debugPrint('Navigating to /dashboard');
          context.go('/dashboard');
          return;
        }
      }
      debugPrint('Navigating to /introslider-screen');
      context.go('/introslider-screen');
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
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
