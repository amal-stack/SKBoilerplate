import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/countdown_timer.dart';
import '../../../../shared/themes/text.dart' as custom;
import '../../../../shared/themes/text.dart';
import '../../../../shared/utils/app_colors.dart';
import '../../../../shared/utils/app_images.dart';
import '../../../../shared/validators.dart';
import '../../../../shared/widgets/animated_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../cubit/reset_password_cubit.dart';
import '../cubit/state.dart';
import 'remember_password_link.dart';

const resendOtpSeconds = 120;

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key, required this.email, required this.code});

  final String email;

  final String code;

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  bool isFormValid = false;

  void _validateForm() {
    final valid = (_formKey.currentState?.validate() ?? false);
    if (valid != isFormValid) {
      setState(() {
        isFormValid = valid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, AuthOperationState<String>>(
      builder: (context, state) => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(AppImages.appThemeIcon, width: 122.w, height: 48.h),
            SizedBox(height: 40.h),
            RegularText(
              textAlign: TextAlign.center,
              textSize: 24.sp,
              maxLines: 1,
              fontWeight: FontWeight.w700,
              textColor: AppColors.titleBlackColor,
              textOverflow: TextOverflow.ellipsis,
              text: 'Reset password?',
            ),
            SizedBox(height: 5.h),
            RegularText(
              textAlign: TextAlign.center,
              textSize: 12.sp,
              maxLines: 1,
              fontWeight: FontWeight.w500,
              textColor: AppColors.lightBlack,
              textOverflow: TextOverflow.ellipsis,
              text: 'Please do not enter an old password',
            ),
            SizedBox(height: 30.h),

            SizedBox(height: 30.h),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: RegularText(
                  textAlign: TextAlign.start,
                  textSize: 14.sp,
                  maxLines: 2,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.borderBlack,
                  textOverflow: TextOverflow.ellipsis,
                  text: "Enter new password",
                ),
              ),
            ),
            SizedBox(height: 8.h),
            InputTextField(
              label: "Password",
              hintMessage: "Enter Password",
              validator: Validators.validatePassword,
              controller: _passwordController,
              onChanged: (val) => _validateForm(),
              isSecure: true,
            ),
            SizedBox(height: 30.h),
            SizedBox(
              height: 45.h,
              width: double.infinity,
              child: AnimatedButton(
                isLoading: state is AuthOperationLoading,
                onPressed: () {
                  context.read<ResetPasswordCubit>().resetPassword(
                    widget.email,
                    widget.code,
                    _passwordController.text.trim(),
                  );
                },
                label: 'Reset Password',
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 30.h),
            const RememberPasswordLink(),
          ],
        ),
      ),
    );
  }
}

class ResendOtpLink extends StatelessWidget {
  const ResendOtpLink({
    super.key,
    required this.timer,
    required this.onResendOtp,
  });

  final CountdownTimer timer;
  final VoidCallback onResendOtp;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topRight,
    child: timer.isRunning
        ? custom.RichText(
            texts: [
              TextModel(
                'Resend OTP',
                size: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.greyColor,
              ),
              TextModel(
                '  (${timer.displayString})',
                size: 12.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.blackNavigationColor,
              ),
            ],
          )
        : GestureDetector(
            onTap: onResendOtp,
            child: RegularText(
              text: 'Resend OTP',
              textAlign: TextAlign.center,
              textSize: 12.sp,
              fontWeight: FontWeight.w800,
              textColor: AppColors.baseColor,
            ),
          ),
  );
}
