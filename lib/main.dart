import 'package:boilerplate/src/core/dependencies.dart';
import 'package:boilerplate/src/features/auth/data/repositories/remote/remote_auth_repository.dart';
import 'package:boilerplate/src/features/auth/data/repositories/remote/remote_user_repository.dart';
import 'package:boilerplate/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:boilerplate/src/features/auth/domain/repositories/user_repository.dart';
import 'package:boilerplate/src/features/brands/data/repositories/remote/remote_brands_repository.dart';
import 'package:boilerplate/src/features/brands/domain/repositories/brands_repository.dart';
import 'package:boilerplate/src/features/products/data/repositories/remote/remote_products_repository.dart';
import 'package:boilerplate/src/features/products/domain/repositories/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'src/core/app_router.dart';
import 'src/core/network/connectivity_service.dart';
import 'src/shared/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConnectivityService.initialize();

  final dependencies = Dependencies.defaults();

  runApp(SwitchKartApp(dependencies: dependencies));
}

class SwitchKartApp extends StatelessWidget {
  const SwitchKartApp({super.key, required this.dependencies});

  final Dependencies dependencies;

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthRepository>(
        create: (context) => RemoteAuthRepository(dependencies.authSource),
      ),
      RepositoryProvider<UserRepository>(
        create: (context) => RemoteUserRepository(dependencies.authSource),
      ),
      RepositoryProvider<BrandsRepository>(
        create: (context) => RemoteBrandsRepository(dependencies.brandsDataSource),
      ),
      RepositoryProvider<ProductsRepository>(
        create: (context) => RemoteProductsRepository(dependencies.productsDataSource),
      ),
    ],
    child: const AppView(),
  );
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_, _) => StreamBuilder<bool>(
      stream: ConnectivityService.instance.connectionStream,
      initialData: true,
      builder: (context, snapshot) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'SwitchKart',
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
        builder: (context, child) =>
            Column(children: [Expanded(child: child ?? const SizedBox())]),
      ),
    ),
  );
}
