import 'package:boilerplate/src/features/questionaire/data/data_sources/questionnaire_data_source.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/animated_button.dart';

class ProductQuestionAnswerScreen extends StatefulWidget {
  const ProductQuestionAnswerScreen({super.key});

  @override
  State<ProductQuestionAnswerScreen> createState() =>
      _ProductQuestionAnswerScreenState();
}

class _ProductQuestionAnswerScreenState
    extends State<ProductQuestionAnswerScreen> {
  Map<int, String> selectedAnswers = {}; // Track each question's answer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: GestureDetector(
            onTap: () => context.pop(),
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
          onPressed: () => Navigator.pop(context),
        ),
        title: RegularText(
          textAlign: TextAlign.start,
          textSize: 20.sp,
          maxLines: 1,
          fontWeight: FontWeight.w700,
          textColor: AppColors.black,
          textOverflow: TextOverflow.ellipsis,
          text: "Verify product condition",
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: AppColors.dividerColor, height: 1),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                      ListView.builder(
                        itemCount: QuestionnaireData.questions.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: questionAnswerWidget(
                              question: QuestionnaireData.questions[index].text,
                              index: index, // pass the index
                              onChanged: (answer) {
                                print("Q${index + 1}: $answer");
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
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
                      disableButton: false,
                      isLoading: false,
                      onPressed: () =>
                          context.push('/product-condition-screen'),
                      label: AppTexts.continueTitle,
                      fontSize: 12.sp,
                      isSmallButton: false,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget questionAnswerWidget({
    required String question,
    required int index, // index for this question
    required ValueChanged<String> onChanged,
  }) {
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
          text: question,
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Row(
            children: [
              answerButtonWidget(index, "Yes", onChanged),
              SizedBox(width: 10.w),
              answerButtonWidget(index, "No", onChanged),
            ],
          ),
        ),
      ],
    );
  }

  Widget answerButtonWidget(
    int index,
    String value,
    ValueChanged<String> onChanged,
  ) {
    final isSelected = selectedAnswers[index] == value; // check per question
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswers[index] = value; // update only this question
        });
        onChanged(value);
      },
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
            text: value,
          ),
        ),
      ),
    );
  }
}


class QuestionAnswerWidget extends StatelessWidget {
  const QuestionAnswerWidget({super.key, required this.question, required this.onChanged});

  final AssessmentQuestion question;

  final ValueChanged<bool> onChanged;

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
                isSelected: false,
                onPressed: () => onChanged(true),
              ),
              SizedBox(width: 10.w),
              AnswerButton.no(
                isSelected: false,
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
