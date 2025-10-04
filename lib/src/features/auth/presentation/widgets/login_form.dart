import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/themes/text.dart';
import '../../../../shared/utils/app_colors.dart';
import '../../../../shared/utils/app_images.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/app_texts.dart';
import '../../../../shared/validators.dart';
import '../../../../shared/widgets/animated_button.dart';

import '../../../../shared/widgets/custom_text_field.dart';

import '../../domain/entities/authentication.dart';
import '../cubit/login_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isFormValid = false;

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginCubit, Authentication>(
    builder: (context, state) => Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.appLogoBlack, width: 210.w, height: 48.h),
          SizedBox(height: 20.h),
          RegularText(
            textAlign: TextAlign.center,
            textSize: 12.sp,
            maxLines: 2,
            fontWeight: FontWeight.w400,
            textColor: AppColors.blackNavigationColor,
            textOverflow: TextOverflow.ellipsis,
            text: AppTexts.loginSubTitle,
          ),
          SizedBox(height: 50.h),
          // SizedBox(height: 45.h,
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
            onChanged: (val) => _validateForm(),
          ),
          SizedBox(height: 20.h),
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
                text: "Password",
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
          SizedBox(height: 20.h),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => context.go(AppRoutes.forgotPassword),
              child: RegularText(
                textAlign: TextAlign.center,
                textSize: 12.sp,
                maxLines: 1,
                fontWeight: FontWeight.w500,
                textColor: AppColors.baseColor,
                textOverflow: TextOverflow.ellipsis,
                text: 'Forgot Password?',
              ),
            ),
          ),
          SizedBox(height: 30.h),
          SizedBox(
            height: 45.h,
            child: AnimatedButton(
              disableButton: !_isFormValid,
              isLoading: state is LoadingAuthentication,
              onPressed: _login,
              label: 'LOGIN',
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    ),
  );
}
