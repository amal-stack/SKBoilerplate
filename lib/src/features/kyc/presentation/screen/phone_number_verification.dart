import 'dart:async';

import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/validators.dart';
import 'package:boilerplate/src/shared/widgets/animated_button.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class PhoneNumberVerification extends StatefulWidget {
  const PhoneNumberVerification({super.key});

  @override
  State<PhoneNumberVerification> createState() =>
      _PhoneNumberVerificationState();
}

class _PhoneNumberVerificationState extends State<PhoneNumberVerification> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  bool isOTPSend = false;

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
        border: Border.all(color: AppColors.baseColor, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.grey.shade100,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          icon: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Image.asset(
                "assets/images/left_arrow.png",
                width: 24.w,
                height: 24.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: RegularText(
          textAlign: TextAlign.start,
          textSize: 20.sp,
          maxLines: 1,
          fontWeight: FontWeight.w700,
          textColor: AppColors.black,
          textOverflow: TextOverflow.ellipsis,
          text: "KYC Verification",
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            color: AppColors.dividerColor, // grey divider line
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      RegularText(
                        text: "Verify your contact number",
                        textSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                      ),
                      SizedBox(height: 24.h),
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
                            text: "Mobile number",
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      InputTextField(
                        label: "Mobile number",
                        hintMessage: "Enter Mobile Number",
                        validator: Validators.validateMobileNumber,
                        maxLength: 12,
                        controller: mobileNumberController,
                        //   controller: _emailController,
                        // onChanged: (val) => _validateForm(),
                      ),
                      SizedBox(height: 24.h),

                      isOTPSend == true
                          ? RegularText(
                            textAlign: TextAlign.start,
                            textSize: 14.sp,
                            maxLines: 2,
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.borderBlack,
                            textOverflow: TextOverflow.ellipsis,
                            text: "Enter  OTP",
                          )
                          : Container(),
                      SizedBox(height: 24.h),
                      isOTPSend == true
                          ? Pinput(
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
                                value = _pinController.text;
                              });
                            },
                            onCompleted: (pin) {
                              debugPrint('OTP completed: $pin');
                            },
                          )
                          : Container(),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 45.h,
                    width: double.infinity,
                    child: AnimatedButton(
                      disableButton:
                          isOTPSend == false
                              ? mobileNumberController.text.length == 10
                                  ? false
                                  : true
                              : false,
                      isLoading: false,

                      onPressed: () {
                        if (isOTPSend == true) {
                          context.push(
                            '/phone-number-verification-success-screen',
                          );
                        } else {
                          setState(() {
                            isOTPSend = true;
                          });
                        }
                      },
                      // () => context.push(
                      //   '/phone-number-verification-success-screen',
                      // ),
                      label: AppTexts.continueTitle,
                      fontSize: 12.sp,
                      isSmallButton: false,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
