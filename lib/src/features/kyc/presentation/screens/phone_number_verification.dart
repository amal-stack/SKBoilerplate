
import 'package:boilerplate/src/features/kyc/presentation/cubits/kyc_phone_verification_cubit.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/validators.dart';
import 'package:boilerplate/src/shared/widgets/animated_button.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class PhoneNumberVerification extends StatefulWidget {
  const PhoneNumberVerification({super.key, required this.quoteId});

  final String quoteId;

  @override
  State<PhoneNumberVerification> createState() =>
      _PhoneNumberVerificationState();
}

class _PhoneNumberVerificationState extends State<PhoneNumberVerification> {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KycPhoneVerificationCubit(context.read()),
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
            child: KycPhoneVerificationForm(),
          ),
        ),
      ),
    );
  }
}

class KycPhoneVerificationForm extends StatelessWidget {
  const KycPhoneVerificationForm({super.key});

  @override
  Widget build(BuildContext context) {
    // Base style for each box
    bool isOTPSend = 1 != 1;
    return Column(
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
                SizedBox(height: 24.h),
                if (isOTPSend) _OtpSection(),
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
                  if (isOTPSend == true) {
                    context.push('/phone-number-verification-success-screen');
                  } else {
                    // setState(() {
                    //   isOTPSend = true;
                    // });
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
    );
  }
}

class _OtpSection extends StatelessWidget {
  const _OtpSection();

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

    return Column(
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
              ),
            ],
          );
  }
}

class _PhoneNumberSection extends StatelessWidget {
  const _PhoneNumberSection();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<KycPhoneVerificationCubit>();

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
                initialValue: "91",
                maxLength: 3,
                onChanged: (value) {
                  cubit.countryCodeChanged(value);
                },
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
                maxLength: 12,
                onChanged: (value) {
                  cubit.phoneNumberChanged(value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
