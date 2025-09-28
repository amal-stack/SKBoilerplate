import 'package:boilerplate/src/shared/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_client.dart';
import '../../../../shared/themes/text.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_colors.dart';
import '../../../../shared/utils/app_texts.dart';
import '../../../../shared/validators.dart';
import '../../../../shared/widgets/animated_button.dart';
import '../../repositories/auth_repository.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isFormValid = false;
  bool isLoading = false;

  void _validateForm() {
    final valid = (_formKey.currentState?.validate() ?? false);
    if (valid != isFormValid) {
      setState(() {
        isFormValid = valid;
      });
    }
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(AuthRepository(ApiClient())),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.success) {
            context.go('/dashboard');
          } else if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.background),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24.w),
                    child: Form(
                      key: _formKey,
                      child: loginForm(context, state),
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

  Widget loginForm(BuildContext context, LoginState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppAssets.appName, width: 210.w, height: 48.h),
        SizedBox(height: 20.h),
        RegularText(
          textAlign: TextAlign.center,
          textSize: 12.sp,
          maxLines: 2,
          fontWeight: FontWeight.w500,
          textColor: AppColors.borderBlack,
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
          // onChanged: (val) => _validateForm(),
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
            onTap: () => context.push('/forgot-password'),
            child: RegularText(
              textAlign: TextAlign.end,
              textSize: 12.sp,
              maxLines: 1,
              fontWeight: FontWeight.w600,
              textColor: AppColors.baseColor,
              textOverflow: TextOverflow.ellipsis,
              text: AppTexts.forgotPasswordQue,
            ),
          ),
        ),
        SizedBox(height: 30.h),
        SizedBox(
          height: 45.h,
          child: AnimatedButton(
            disableButton: !isFormValid,
            isLoading: isLoading ? true : false,
           // isLoading: state.loading,
            onPressed: () async{
              setState(() {
                isLoading = true;
              });
              await Future.delayed(const Duration(seconds: 2));
              setState(() {
                isLoading = false;
              });

              context.push('/dashboard');
            },
            // onPressed: () => _onLogin(context),
            label: AppTexts.login,
            fontSize: 12.sp,
            isSmallButton: false,
          ),
        ),
      ],
    );
  }
}
