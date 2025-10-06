import 'package:boilerplate/src/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:boilerplate/src/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:boilerplate/src/features/auth/presentation/cubit/state.dart';
import 'package:boilerplate/src/features/auth/presentation/widgets/reset_password_form.dart';
import 'package:boilerplate/src/shared/countdown_timer.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/widgets/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationForm extends StatefulWidget {
  const OtpVerificationForm({super.key, required this.email});

  final String email;

  @override
  State<OtpVerificationForm> createState() => _OtpVerificationFormState();
}

class _OtpVerificationFormState extends State<OtpVerificationForm> {
  final _formKey = GlobalKey<FormState>();

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
    _pinController.dispose();
    _pinFocusNode.dispose();
    timer.dispose();

    super.dispose();
  }

  void _onResendOtp() {
    context.read<OtpCubit>().resendOtp(widget.email);

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
    return Form(
      key: _formKey,
      child: SizedBox(
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
            BlocBuilder<OtpCubit, AuthOperationState<OtpState>>(
              builder: (context, state) => SizedBox(
                height: 45.h,
                width: double.infinity,
                child: AnimatedButton(
                  isLoading: state is AuthOperationLoading,
                  onPressed: () {
                    context.read<OtpCubit>().verifyOtp(
                      widget.email,
                      _pinController.text.trim(),
                    );
                  },
                  label: 'Verify',
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
