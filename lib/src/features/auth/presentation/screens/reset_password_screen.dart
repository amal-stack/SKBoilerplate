import 'package:boilerplate/src/shared/themes/text.dart' as custom;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_feild.dart';

import '../../../../shared/themes/text.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_colors.dart';
import '../../../../shared/utils/app_texts.dart';
import '../../../../shared/widgets/animated_button.dart';
import '../cubit/forgot_password_cubit.dart';
import '../../../../shared/validators.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    // _passwordController.addListener(_validateForm);
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
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ForgotPasswordCubit>().sendResetLink(
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.success) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text("Reset link sent! Check your email."),
            //   ),
            // );
            // context.go('/otp-verification', extra: state.email);
          } else if (state.error != null) {
            // ScaffoldMessenger.of(
            //   context,
            // ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.white,
            body: Container(
              decoration: const BoxDecoration(
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
                        ),
                        SizedBox(height: 80.h),
                        RegularText(
                          textAlign: TextAlign.center,
                          textSize: 24.sp,
                          maxLines: 1,
                          fontWeight: FontWeight.w700,
                          textColor: AppColors.titleBlackColor,
                          textOverflow: TextOverflow.ellipsis,
                          text: AppTexts.resetPasswordQes,
                        ),
                        SizedBox(height: 10.h),
                        RegularText(
                          textAlign: TextAlign.center,
                          textSize: 12.sp,
                          maxLines: 1,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.borderBlack,
                          textOverflow: TextOverflow.ellipsis,
                          text: AppTexts.resetPasswordSubTitle,
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
                        // TextFormField(
                        //   controller: _passwordController,
                        //   obscureText: true,
                        //   decoration: InputDecoration(
                        //     labelText: AppTexts.newPasswordTitle,
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(8.r),
                        //     ),
                        //   ),
                        //   onChanged: (val) {
                        //     setState(() {});
                        //   },
                        //   //  validator: Validators.validatePassword(),
                        // ),
                        SizedBox(height: 30.h),
                        SizedBox(
                          height: 45.h,
                          width: double.infinity,
                          child: AnimatedButton(
                            disableButton:
                                _passwordController.text.length < 6
                                    ? true
                                    : false,
                            isLoading: state.loading,
                            onPressed: () {
                              context.go('/success-screen');
                            },
                            label: AppTexts.resetPassword,
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
