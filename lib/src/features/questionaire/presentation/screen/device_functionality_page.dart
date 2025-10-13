import 'package:boilerplate/src/features/questionaire/data/data_sources/local/questionnaire_store.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_assessment_cubit.dart';
import 'package:boilerplate/src/features/questionaire/presentation/models/flow_state.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeviceFunctionalityPage extends StatelessWidget {
  const DeviceFunctionalityPage({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.h),
        // SizedBox(height: 24.h),
        RegularText(
          textAlign: TextAlign.start,
          textSize: 12.sp,
          maxLines: 2,
          fontWeight: FontWeight.w600,
          textColor: AppColors.borderBlack,
          textOverflow: TextOverflow.ellipsis,
          text: "Select Yes/No to get the accurate pricing",
        ),
        SizedBox(height: 20.h),
        DeviceFunctionalityQuestionsList(
          questions: QuestionnaireStore.functionalityQuestions,
        ),
        SizedBox(height: 20.h),
      ],
    ),
  );
}

class DeviceFunctionalityQuestionsList extends StatelessWidget {
  const DeviceFunctionalityQuestionsList({super.key, required this.questions});

  final List<AssessmentQuestion> questions;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<DeviceAssessmentCubit, DeviceAssessmentState>(
        builder: (context, state) => ListView.builder(
          itemCount: questions.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: QuestionAnswerWidget(
                question: questions[index],
                selection: state.input.functionality?.answerForQuestion(
                  questions[index],
                ),
                onChanged: (answer) {
                  context
                      .read<DeviceAssessmentCubit>()
                      .answerFunctionalityQuestion(
                        question: questions[index],
                        answer: answer,
                      );
                },
              ),
            );
          },
        ),
      );
}

class QuestionAnswerWidget extends StatelessWidget {
  const QuestionAnswerWidget({
    super.key,
    required this.question,
    required this.onChanged,
    required this.selection,
  });

  final AssessmentQuestion question;

  final ValueChanged<bool> onChanged;

  final bool? selection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RegularText(
          textAlign: TextAlign.start,
          textSize: 12.sp,
          maxLines: 2,
          fontWeight: FontWeight.w700,
          textColor: AppColors.borderBlack,
          textOverflow: TextOverflow.ellipsis,
          text: question.text,
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Row(
            children: [
              AnswerButton.yes(
                isSelected: selection == true,
                onPressed: () => onChanged(true),
              ),
              SizedBox(width: 10.w),
              AnswerButton.no(
                isSelected: selection == false,
                onPressed: () => onChanged(false),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AnswerButton extends StatelessWidget {
  const AnswerButton.yes({
    super.key,
    required this.isSelected,
    required this.onPressed,
  }) : value = true;

  const AnswerButton.no({
    super.key,
    required this.isSelected,
    required this.onPressed,
  }) : value = false;

  final bool isSelected;

  final VoidCallback onPressed;

  final bool value; // true for Yes, false for No

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 140.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.introSliderCircleColor : Colors.white,
          border: Border.all(
            width: 1.w,
            color: isSelected
                ? AppColors.introSliderCircleColor
                : AppColors.greyBorderColor,
          ),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Align(
          alignment: Alignment.center,
          child: RegularText(
            textAlign: TextAlign.center,
            textSize: 12.sp,
            maxLines: 1,
            fontWeight: FontWeight.w700,
            textColor: isSelected ? AppColors.black : AppColors.black,
            textOverflow: TextOverflow.ellipsis,
            text: value ? "Yes" : "No",
          ),
        ),
      ),
    );
  }
}
