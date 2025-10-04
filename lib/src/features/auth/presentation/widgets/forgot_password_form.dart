import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/themes/text.dart' as custom;
import '../../../../shared/themes/text.dart';
import '../../../../shared/utils/app_colors.dart';
import '../../../../shared/utils/app_images.dart';
import '../../../../shared/validators.dart';
import '../../../../shared/widgets/animated_button.dart';

import '../../../../shared/widgets/custom_text_field.dart';

import '../cubit/forgot_password_cubit.dart';
import '../cubit/state.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
  }

  void _validateForm() {
    final valid = (_formKey.currentState?.validate() ?? false);
    if (valid != isFormValid) {
      setState(() {
        isFormValid = valid;
      });
    }
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ForgotPasswordCubit>().forgotPassword(
        _emailController.text.trim(),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AppImages.appThemeIcon,
          width: 122.w,
          height: 48.h,
        ),
        SizedBox(height: 80.h),
        RegularText(
          textAlign: TextAlign.center,
          textSize: 24.sp,
          maxLines: 1,
          fontWeight: FontWeight.w700,
          textColor: AppColors.titleBlackColor,
          textOverflow: TextOverflow.ellipsis,
          text: 'Forgot Password?',
        ),
        SizedBox(height: 5.h),
        RegularText(
          textAlign: TextAlign.center,
          textSize: 12.sp,
          maxLines: 1,
          fontWeight: FontWeight.w500,
          textColor: AppColors.lightBlack,
          textOverflow: TextOverflow.ellipsis,
          text: 'Please enter valid e-mail ID to reset the password',
        ),
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
              text: "Email",
            ),
          ),
        ),
        SizedBox(height: 8.h),
        InputTextField(
          label: "Email",
          hintMessage: "Enter Email",
          validator: Validators.validateEmail,
          controller: _emailController,
          // onChanged: (val) => _validateForm(),
        ),
        SizedBox(height: 30.h),
        BlocBuilder<
          ForgotPasswordCubit,
          AuthOperationState<ForgotPasswordDetails>
        >(
          builder: (context, state) => SizedBox(
            height: 45.h,
            width: double.infinity,
            child: AnimatedButton(
              disableButton: !isFormValid,
              isLoading: state is AuthOperationLoading,
              onPressed: state is AuthOperationLoading ? null : _onSubmit,
              label: 'Get OTP',
              fontSize: 12.sp,
            ),
          ),
        ),
        SizedBox(height: 30.h),
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Container(
            alignment: Alignment.center,
            child: custom.RichText(
              texts: [
                TextModel(
                  'Remember password?',
                  size: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightBlack,
                ),
                TextModel(
                  ' Sign In',
                  size: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.baseColor.withValues(alpha: 0.8),
                ),
              ],
              maxLines: 3,
            ),
          ),
        ),
      ],
    ),
  );
}
