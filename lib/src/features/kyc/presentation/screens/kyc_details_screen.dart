import 'package:boilerplate/src/features/kyc/presentation/cubits/kyc_details_cubit.dart';
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

class KycDetailsScreen extends StatefulWidget {
  const KycDetailsScreen({super.key, required this.quoteId});

  final String quoteId;

  @override
  State<KycDetailsScreen> createState() => _KycDetailsScreenState();
}

class _KycDetailsScreenState extends State<KycDetailsScreen> {
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) =>
        KycDetailsCubit(context.read(), quoteId: widget.quoteId),
    child: Scaffold(
      backgroundColor: AppColors.white,
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
          child: KycDetailsForm(),
        ),
      ),
    ),
  );
}

class KycDetailsForm extends StatelessWidget {
  const KycDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<KycDetailsCubit>();
    return BlocListener(
      bloc: cubit,
      listener: (context, state) {
        switch (state) {
          case KycDetailsSubmitted():
            context.push('/upload-documents-screen/${cubit.quoteId}');
          case KycDetailsError(:final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: RegularText(text: message, textColor: AppColors.white),
              ),
            );
          case KycDetailsInput():
          // Do nothing
        }
      },
      child: Form(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: RegularText(
                          textAlign: TextAlign.start,
                          textSize: 16.sp,
                          maxLines: 2,
                          fontWeight: FontWeight.w700,
                          textColor: AppColors.borderBlack,
                          textOverflow: TextOverflow.ellipsis,
                          text: "Provide your details",
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 100.h,
                          width: 150.w,
                          child: Column(
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
                                    text: "First Name",
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              InputTextField(
                                textInputType: TextInputType.name,
                                label: "First Name",
                                hintMessage: "First Name",
                                onChanged: (value) {
                                  cubit.detailsChanged(
                                    cubit.state.details.copyWith(
                                      firstName: value,
                                    ),
                                  );
                                },
                                validator: (value) =>
                                    Validators.validateNotEmpty(
                                      value,
                                      "First Name",
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100.h,
                          width: 150.w,
                          child: Column(
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
                                    text: "Last Name",
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              InputTextField(
                                textInputType: TextInputType.name,
                                label: "Last Name",
                                hintMessage: "Last Name",
                                onChanged: (value) {
                                  cubit.detailsChanged(
                                    cubit.state.details.copyWith(
                                      lastName: value,
                                    ),
                                  );
                                },
                                validator: (value) =>
                                    Validators.validateNotEmpty(
                                      value,
                                      "Last Name",
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
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
                          text: "Address (Line 1)* ",
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    InputTextField(
                      label: "Address (Line 1)* ",
                      hintMessage: "Address (Line 1)*",
                      onChanged: (value) {
                        final details = cubit.state.details;
                        cubit.detailsChanged(
                          details.copyWith(
                            address: details.address.copyWith(
                              addressLine1: value,
                            ),
                          ),
                        );
                      },
                      validator: (value) => Validators.validateNotEmpty(
                        value,
                        "Address (Line 1)",
                      ),
                      textInputType: TextInputType.streetAddress,
                    ),
                    SizedBox(height: 8.h),
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
                          text: "Address (Line 2)* ",
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    InputTextField(
                      label: "Address (Line 2)* ",
                      hintMessage: "Address (Line 2)*",
                      onChanged: (value) {
                        final details = cubit.state.details;
                        cubit.detailsChanged(
                          details.copyWith(
                            address: details.address.copyWith(
                              addressLine2: value,
                            ),
                          ),
                        );
                      },
                      validator: (value) => Validators.validateNotEmpty(
                        value,
                        "Address (Line 2)",
                      ),
                      textInputType: TextInputType.streetAddress,
                    ),
                    SizedBox(height: 8.h),
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
                          text: "Address (Line 3)* ",
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    InputTextField(
                      label: "Address (Line 3)* ",
                      hintMessage: "Address (Line 3)*",
                      onChanged: (value) {
                        final details = cubit.state.details;
                        cubit.detailsChanged(
                          details.copyWith(
                            address: details.address.copyWith(
                              addressLine3: value,
                            ),
                          ),
                        );
                      },
                      validator: (value) => Validators.validateNotEmpty(
                        value,
                        "Address (Line 3)",
                      ),
                      textInputType: TextInputType.streetAddress,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 100.h,
                          width: 150.w,
                          child: Column(
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
                                    text: "City",
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              InputTextField(
                                label: "City",
                                hintMessage: "City",
                                onChanged: (value) {
                                  final details = cubit.state.details;
                                  cubit.detailsChanged(
                                    details.copyWith(
                                      address: details.address.copyWith(
                                        city: value,
                                      ),
                                    ),
                                  );
                                },
                                validator: (value) =>
                                    Validators.validateNotEmpty(value, "City"),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100.h,
                          width: 150.w,
                          child: Column(
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
                                    text: "Pin code",
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              InputTextField(
                                label: "Pin code",
                                hintMessage: "Pin code",
                                onChanged: (value) {
                                  final details = cubit.state.details;
                                  cubit.detailsChanged(
                                    details.copyWith(
                                      address: details.address.copyWith(
                                        pincode: value,
                                      ),
                                    ),
                                  );
                                },
                                validator: (value) =>
                                    Validators.validateNotEmpty(
                                      value,
                                      "Pin code",
                                    ),
                                textInputType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
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
                          text: "State ",
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    InputTextField(
                      label: "State",
                      hintMessage: "State",
                      onChanged: (value) {
                        final details = cubit.state.details;
                        cubit.detailsChanged(
                          details.copyWith(
                            address: details.address.copyWith(state: value),
                          ),
                        );
                      },
                      validator: (value) =>
                          Validators.validateNotEmpty(value, "State"),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
            _SubmitDetailsButton(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

class _SubmitDetailsButton extends StatelessWidget {
  const _SubmitDetailsButton();


  @override
  Widget build(BuildContext context) {
    final cubit = context.read<KycDetailsCubit>();
    return SizedBox(
      height: 45.h,
      width: double.infinity,
      child: AnimatedButton(
        disableButton: false,
        isLoading: cubit.state is KycDetailsSubmitting,
        onPressed: () {
          if (!Form.of(context).validate()) {
            return;
          }
          cubit.submitKycDetails();
        },
        label: AppTexts.continueTitle,
        fontSize: 12.sp,
        isSmallButton: false,
      ),
    );
  }
}
