import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/utils/app_images.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: false,

    body: DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.backgroundImageAlt),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(padding: EdgeInsets.all(24.w), child: child),
      ),
    ),
  );
}
