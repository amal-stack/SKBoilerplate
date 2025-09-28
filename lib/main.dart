import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'src/core/app_router.dart';
import 'src/core/network/connectivity_service.dart';
import 'src/shared/themes/app_theme.dart';
import 'package:flutter/services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConnectivityService.initialize();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return StreamBuilder<bool>(
          stream: ConnectivityService.instance.connectionStream,
          initialData: true,
          builder: (context, snapshot) {
            final online = snapshot.data ?? true;
            return MaterialApp.router(
              title: 'SwitchKart',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              routerConfig: appRouter,
              builder: (context, child) {
                return Column(
                  children: [Expanded(child: child ?? const SizedBox())],
                );
              },
            );
          },
        );
      },
    );
  }
}
