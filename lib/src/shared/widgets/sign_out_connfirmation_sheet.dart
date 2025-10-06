import 'package:boilerplate/src/features/auth/presentation/cubit/login_cubit.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/widgets/animated_button.dart';
import 'package:boilerplate/src/shared/widgets/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SignOutConfirmationSheet extends StatelessWidget {
  const SignOutConfirmationSheet({super.key});

  @override
  Widget build(BuildContext context) => AppBottomSheet(
    shouldClose: () => false,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset('assets/gifs/log-out.json', height: 150.h),
        const RegularText(
          textAlign: TextAlign.center,
          text: 'Are you sure, you want to log out from \n the Application?',
          textColor: AppColors.lightGreyColor,
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 150.w,
              child: AnimatedButton(
                isSmallButton: true,
                onPressed: () {
                  context.read<LoginCubit>().logout();
                },
                buttonColor: AppColors.baseColor.withValues(alpha: 0.8),
                label: 'Yes',
                labelColor: AppColors.white,
              ),
            ),
            SizedBox(width: 8.w),
            SizedBox(
              width: 150.w,
              child: AnimatedButton(
                isSmallButton: true,
                onPressed: () {
                  context.pop();
                },
                buttonColor: AppColors.greyColor,
                label: 'No',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
