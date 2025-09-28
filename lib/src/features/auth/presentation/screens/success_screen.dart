import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../shared/themes/text.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_colors.dart';
import '../../../../shared/utils/app_texts.dart';
import '../../../../shared/widgets/animated_button.dart';
import '../cubit/forgot_password_cubit.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.success) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text("Reset link sent! Check your email."),
            //   ),
            // );
            // context.go('/otp-verification', extra: state.email);
          } else if (state.error != null) {
            // ScaffoldMessenger.of(
            //   context,
            // ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(24.w),

                  // key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Image.asset(
                        AppAssets.appName,
                        width: 122.w,
                        height: 48.h,
                      ),
                      SizedBox(height: 120.h),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 70.w,
                              height: 70.h,
                              child: Lottie.asset('assets/gifs/Success.json'),
                            ),

                            // Image.asset(
                            //   AppAssets.successIcon,
                            //   width: 56.w,
                            //   height: 56.h,
                            // ),
                            SizedBox(height: 30.h),
                            RegularText(
                              textAlign: TextAlign.center,
                              textSize: 18.sp,
                              maxLines: 2,
                              fontWeight: FontWeight.w700,
                              textColor: AppColors.borderBlack,
                              textOverflow: TextOverflow.ellipsis,
                              text: AppTexts.passwordUpdateTitle,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(height: 30.h),
                      SizedBox(
                        height: 45.h,
                        width: double.infinity,
                        child: AnimatedButton(
                          disableButton: false,
                          isLoading: state.loading,
                          onPressed: () {
                            context.go('/login');
                          },
                          label: AppTexts.goToLogin,
                          fontSize: 12.sp,
                          isSmallButton: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
