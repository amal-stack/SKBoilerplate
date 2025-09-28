import 'dart:async';

import 'package:boilerplate/src/shared/themes/text.dart' as custom;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../../shared/themes/text.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_colors.dart';
import '../../../../shared/utils/app_texts.dart';
import '../../../../shared/widgets/animated_button.dart';
import '../cubit/forgot_password_cubit.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String? email;

  const OtpVerificationScreen({super.key, this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  bool isFormValid = false;

  void _startTimer() {
    _secondsRemaining = 120;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  int _secondsRemaining = 120;
  Timer? _timer;

  void _onResendOtp(BuildContext context) {
    // context.read<OtpCubit>().resendOtp(widget.email);
    _startTimer();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    //_otpController.addListener(_validateForm);
  }

  String get _timerText {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Base style for each box
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
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color:AppColors.baseColor, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.grey.shade100,
      ),
    );

    return BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Reset link sent! Check your email."),
              ),
            );
            context.go('/login'); // redirect to login
          } else if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            resizeToAvoidBottomInset: false,
            body: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppAssets.appName,
                          width: 122.w,
                          height: 48.h,
                          alignment: Alignment.topLeft,
                        ),
                        SizedBox(height: 80.h),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RegularText(
                                textAlign: TextAlign.center,
                                textSize: 20.sp,
                                maxLines: 1,
                                fontWeight: FontWeight.w700,
                                textColor: AppColors.borderBlack,
                                textOverflow: TextOverflow.ellipsis,
                                text: AppTexts.verifyOTP,
                              ),
                              SizedBox(height: 10.h),
                              RegularText(
                                textSize: 12.sp,
                                maxLines: 1,
                                fontWeight: FontWeight.w500,
                                textColor: AppColors.borderBlack,
                                textOverflow: TextOverflow.ellipsis,
                                text: AppTexts.getOTPSubTitle,
                              ),
                              SizedBox(height: 20.h),
                              RegularText(
                                textSize: 12.sp,
                                maxLines: 1,
                                fontWeight: FontWeight.w600,
                                textColor: AppColors.borderBlack,
                                textOverflow: TextOverflow.ellipsis,
                                text: "chintandave3019@gmail.com",
                              ),
                              SizedBox(height: 30.h),
                              Pinput(
                                length: 6,
                                controller: _pinController,
                                focusNode: _pinFocusNode,
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: focusedPinTheme,
                                submittedPinTheme: submittedPinTheme,
                                closeKeyboardWhenCompleted: true,
                                obscureText: true,

                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  debugPrint('OTP changed: $value');
                                  print("length : ${_pinController.text.length}");
                                  setState(() {
                                    value  = _pinController.text;
                                  });
                                },
                                onCompleted: (pin) {
                                  debugPrint('OTP completed: $pin');
                                },
                              ),
                              SizedBox(height: 30.h),
                              // Timer or Resend button
                              _secondsRemaining > 0
                                  ? Align(
                                    alignment: Alignment.topRight,

                                    child: Container(
                                      alignment: Alignment.topRight,
                                      child: custom.RichText(
                                        texts: [
                                          TextModel(
                                            AppTexts.resendOTP,
                                            size: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.baseColor,
                                          ),
                                          TextModel(
                                            "  ($_timerText)",
                                            size: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                AppColors.blackNavigationColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  : Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () => _onResendOtp(context),
                                      child: RegularText(
                                        text: AppTexts.resendOTP,
                                        textAlign: TextAlign.center,
                                        textSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        textColor: AppColors.baseColor,
                                      ),
                                    ),
                                  ),
                              SizedBox(height: 20.h),
                              SizedBox(
                                height: 45.h,
                                width: double.infinity,
                                child: AnimatedButton(
                                  disableButton:
                                      _pinController.text.length == 6
                                          ? false
                                          : true,
                                //  disableButton: false,
                                  isLoading: state.loading,
                                  onPressed: () {
                                    context.go('/reset-password');
                                  },

                                  label: AppTexts.verify,
                                  fontSize: 12.sp,
                                  isSmallButton: false,
                                ),
                              ),
                              SizedBox(height: 30.h),
                              GestureDetector(
                                onTap: () {
                                  context.go('/login');
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: custom.RichText(
                                    texts: [
                                      TextModel(
                                        AppTexts.rememberPasswordQes,
                                        size: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.lightBlack,
                                      ),
                                      TextModel(
                                        " Sign In",
                                        size: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.baseColor.withValues(
                                          alpha: 0.8,
                                        ),
                                      ),
                                    ],
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
