import 'package:boilerplate/src/shared/themes/text.dart' as custom;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_feild.dart';

import '../../../../shared/themes/text.dart';
import '../../../../shared/utils/app_colors.dart';
import '../../../../shared/utils/app_texts.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/validators.dart';
import '../../../../shared/widgets/animated_button.dart';
import '../cubit/forgot_password_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ForgotPasswordCubit>().sendResetLink(
        _emailController.text.trim(),
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("OTP sent successfully! Check your email."),
              ),
            );
            context.push('/otp-verification', extra: state.email);
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
              decoration:  BoxDecoration(
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
                          text: AppTexts.forgotPasswordQue,
                        ),
                        SizedBox(height: 12.h),
                        RegularText(
                          textAlign: TextAlign.center,
                          textSize: 12.sp,
                          maxLines: 1,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.borderBlack,
                          textOverflow: TextOverflow.ellipsis,
                          text: AppTexts.forgotPasswordSubTitle,
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
                        // TextFormField(
                        //   controller: _emailController,
                        //   decoration: InputDecoration(
                        //     labelText: AppTexts.email,
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(8.r),
                        //     ),
                        //   ),
                        //   validator: Validators.validateEmail,
                        // ),
                        SizedBox(height: 30.h),
                        SizedBox(
                          height: 45.h,
                          width: double.infinity,
                          child: AnimatedButton(
                            disableButton: !isFormValid,
                            isLoading: state.loading,
                            onPressed:
                                state.loading
                                    ? null
                                    : () {
                                      final email =
                                          _emailController.text.trim();
                                      context
                                          .read<ForgotPasswordCubit>()
                                          .sendResetLink(email);
                                    },
                            label: AppTexts.getOTP,
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
