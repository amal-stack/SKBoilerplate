import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_assessment_cubit.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 45.h,
          width: double.infinity,
          child: AnimatedButton(
            disableButton: false,
            isLoading: false,
            onPressed: () {
              //context.push('/product-condition-screen');
              context.read<DeviceAssessmentCubit>().nextStep();
            },
            label: AppTexts.continueTitle,
            fontSize: 12.sp,
            isSmallButton: false,
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
