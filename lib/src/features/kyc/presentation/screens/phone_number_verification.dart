import 'package:boilerplate/src/features/auth/presentation/widgets/reset_password_form.dart';
import 'package:boilerplate/src/features/kyc/presentation/cubits/kyc_phone_verification_cubit.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/validators.dart';
import 'package:boilerplate/src/shared/widgets/animated_button.dart';
import 'package:boilerplate/src/shared/widgets/countdown_timer_builder.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

const resendOtpSeconds = 120;

class PhoneNumberVerification extends StatelessWidget {
  const PhoneNumberVerification({super.key, required this.quoteId});

  final String quoteId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => KycPhoneVerificationCubit(
      context.read(),
      quoteId: quoteId,
      initialPhone: PhoneNumberInput(countryCode: "91", phoneNumber: ""),
    ),
    child: Scaffold(
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
          child: KycPhoneVerificationForm(quoteId: quoteId),
        ),
      ),
    ),
  );
}

class KycPhoneVerificationForm extends StatelessWidget {
  const KycPhoneVerificationForm({super.key, required this.quoteId});

  final String quoteId;

  @override
  Widget build(BuildContext context) {
    // Base style for each box
    return BlocListener<KycPhoneVerificationCubit, KycPhoneVerificationState>(
      listener: (context, state) {
        switch (state) {
          case KycPhoneVerificationComplete():
            context.push('/phone-verification-success-screen/$quoteId');
          case KycPhoneVerificationError(error: final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: RegularText(text: message, textColor: AppColors.white),
              ),
            );
          default:
          // Do nothing
        }
      },

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
                  _PhoneNumberSection(),
                  SizedBox(height: 64.h),
                  _OtpSection(),
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
                  // disableButton: isOTPSend == false
                  //     ? _phoneController.text.length == 10
                  //           ? false
                  //           : true
                  //     : false,
                  // isLoading: false,
                  onPressed: () {
                    final cubit = context.read<KycPhoneVerificationCubit>();

                    switch (cubit.state.step) {
                      case PhoneEntryStep():
                        cubit.sendOtp();
                      case OtpVerificationStep():
                        cubit.verifyOtp(quoteId: quoteId);
                    }

                    // if (isOTPSend == true) {
                    //   context.push('/phone-number-verification-success-screen');
                    // } else {
                    //   // setState(() {
                    //   //   isOTPSend = true;
                    //   // });
                    // }
                  },

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
    );
  }
}

class _OtpSection extends StatefulWidget {
  const _OtpSection();

  @override
  State<_OtpSection> createState() => _OtpSectionState();
}

class _OtpSectionState extends State<_OtpSection> {
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
        border: Border.all(color: AppColors.baseColor, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.grey.shade100,
      ),
    );

    final cubit = context.read<KycPhoneVerificationCubit>();

    return BlocBuilder<KycPhoneVerificationCubit, KycPhoneVerificationState>(
      builder: (context, state) {
        final show = state.step is OtpVerificationStep;
        if (!show) {
          return SizedBox.shrink();
        }
        final canEdit = state.step is OtpVerificationStep;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegularText(
              textAlign: TextAlign.start,
              textSize: 14.sp,
              maxLines: 2,
              fontWeight: FontWeight.w600,
              textColor: AppColors.borderBlack,
              textOverflow: TextOverflow.ellipsis,
              text: "Enter OTP",
            ),
            SizedBox(height: 24.h),
            Pinput(
              length: 6,
              onChanged: cubit.otpChanged,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              closeKeyboardWhenCompleted: true,
              obscureText: true,
              keyboardType: TextInputType.number,
              enabled: canEdit,
            ),
            SizedBox(height: 30.h),
            // Timer or Resend button
            CountdownTimerBuilder(
              duration: const Duration(seconds: resendOtpSeconds),
              onComplete: (timer) {
                context.read<KycPhoneVerificationCubit>().enableResendOtp();
              },
              builder: (context, timer, child) => ResendOtpLink(
                timer: timer,
                onResendOtp: () {
                  context.read<KycPhoneVerificationCubit>().resendOtp();
                  timer.start();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PhoneNumberSection extends StatefulWidget {
  const _PhoneNumberSection();

  @override
  State<_PhoneNumberSection> createState() => _PhoneNumberSectionState();
}

class _PhoneNumberSectionState extends State<_PhoneNumberSection> {
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _editPhoneNumber() {
    final cubit = context.read<KycPhoneVerificationCubit>();
    cubit.editPhoneNumber();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _phoneFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<KycPhoneVerificationCubit>();

    return BlocBuilder<KycPhoneVerificationCubit, KycPhoneVerificationState>(
      builder: (context, state) {
        final canEdit =
            state.step is PhoneEntryStep &&
            state is! KycPhoneVerificationInProgress;

        final phone = switch (state.step) {
          PhoneEntryStep phoneEntryStep => phoneEntryStep.input,
          OtpVerificationStep otpVerificationStep => otpVerificationStep.phone,
        };

        return Column(
          children: [
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: InputTextField(
                    label: "Country Code",
                    hintMessage: "91",
                    textInputType: TextInputType.phone,
                    prefixText: "+",
                    initialValue: phone.countryCode,
                    maxLength: 3,
                    enabled: canEdit,
                    onChanged: cubit.countryCodeChanged,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  flex: 3,
                  child: InputTextField(
                    label: "Mobile number",
                    hintMessage: "Enter Mobile Number",
                    validator: Validators.validateMobileNumber,
                    textInputType: TextInputType.phone,
                    initialValue: phone.phoneNumber,
                    maxLength: 10,
                    enabled: canEdit,
                    focusNode: _phoneFocusNode,
                    onChanged: cubit.phoneNumberChanged,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            if (state.step case OtpVerificationStep otpStep)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  RegularText(
                    textColor: AppColors.lightGreyColor,
                    textAlign: TextAlign.start,
                    textSize: 12.sp,
                    maxLines: 3,
                    fontWeight: FontWeight.w400,
                    textOverflow: TextOverflow.ellipsis,
                    text:
                        "An OTP has been sent to ${otpStep.phone.fullPhoneNumber}. "
                        "Please enter it below to verify your phone number.",
                  ),
                  GestureDetector(
                    onTap: _editPhoneNumber,

                    child: RegularText(
                      text: 'Edit Number',
                      textAlign: TextAlign.center,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      textColor: AppColors.baseColor,
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
