import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

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
  const ResetPasswordForm({super.key, required this.email});

  final String email;

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _pinController = TextEditingController();

  final FocusNode _pinFocusNode = FocusNode();

  bool isFormValid = false;

  late final CountdownTimer timer;

  @override
  void initState() {
    super.initState();
    _pinController.addListener(_validateForm);

    timer = CountdownTimer(
      duration: const Duration(seconds: resendOtpSeconds),
      onTick: (secondsRemaining) {
        setState(() {});
      },
      onComplete: () {
        setState(() {});
      },
    )..start();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _pinController.dispose();
    _pinFocusNode.dispose();
    timer.dispose();

    super.dispose();
  }

  void _onResendOtp() {
    context.read<ResetPasswordCubit>().resetPassword(
      widget.email,
      _pinController.text.trim(),
      _passwordController.text.trim(),
    );

    timer.start();
  }

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
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // rounded corners
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Theme.of(context).primaryColor, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.grey.shade100,
      ),
    );
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RegularText(
                    textAlign: TextAlign.center,
                    textSize: 20.sp,
                    maxLines: 1,
                    fontWeight: FontWeight.w700,
                    textColor: const Color.fromARGB(255, 149, 149, 198),
                    textOverflow: TextOverflow.ellipsis,
                    text: 'Verify OTP',
                  ),
                  SizedBox(height: 5.h),
                  RegularText(
                    textSize: 12.sp,
                    maxLines: 1,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.lightBlack,
                    textOverflow: TextOverflow.ellipsis,
                    text: 'We have sent a 6 digit OTP to',
                  ),
                  SizedBox(height: 30.h),
                  RegularText(
                    textSize: 12.sp,
                    maxLines: 1,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.lightBlack,
                    textOverflow: TextOverflow.ellipsis,
                    text: widget.email,
                  ),
                  SizedBox(height: 30.h),
                  Pinput(
                    length: 6,
                    controller: _pinController,
                    focusNode: _pinFocusNode,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    obscureText: true,
                    onChanged: (value) {
                      debugPrint('OTP changed: $value');
                    },
                    onCompleted: (pin) {
                      debugPrint('OTP completed: $pin');
                    },
                  ),
                  SizedBox(height: 30.h),
                  // Timer or Resend button
                  ResendOtpLink(timer: timer, onResendOtp: _onResendOtp),
                  SizedBox(height: 20.h),
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
                          _pinController.text.trim(),
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
              fontWeight: FontWeight.w500,
              textColor: AppColors.baseColor,
            ),
          ),
  );
}
