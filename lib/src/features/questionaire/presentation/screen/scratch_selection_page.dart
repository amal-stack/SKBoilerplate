import 'package:boilerplate/src/features/questionaire/data/data_sources/local/questionnaire_store.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_assessment_cubit.dart';
import 'package:boilerplate/src/features/questionaire/presentation/models/flow_state.dart';
import 'package:boilerplate/src/features/questionaire/presentation/screen/product_condition_screen.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScratchSelectionPage extends StatelessWidget {
  const ScratchSelectionPage({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<DeviceAssessmentCubit, DeviceAssessmentState>(
    builder: (context, state) {
      final screenDefects = state.input.screenDefects;
      final cubit = context.read<DeviceAssessmentCubit>();

      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            RegularText(
              text: "Screen cracks/scratches",
              textAlign: TextAlign.start,
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
              textColor: AppColors.black,
            ),
            SizedBox(height: 8.h),
            RegularText(
              text: "Select all the issues/defects in the device",
              textAlign: TextAlign.start,
              textSize: 12.sp,
              fontWeight: FontWeight.w500,
              textColor: AppColors.borderBlack,
            ),
            SizedBox(height: 24.h),
            // Render issues in rows of 2
            IssueGrid([
              IssueData(
                title: QuestionnaireStore.crackedScreenOrBrokenGlass.text,
                image: "assets/images/question/scratch_1.png",
                isSelected: screenDefects?.crackedGlass ?? false,
                onTap: () {
                  final screenDefects =
                      cubit.input.screenDefects ?? ScreenDefects.none;
                  cubit.screenDefectsChanged(
                    screenDefects.copyWith(
                      crackedGlass: !screenDefects.crackedGlass,
                    ),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.cracksOutsideDisplayArea.text,
                image: "assets/images/question/scratch_2.png",
                isSelected: screenDefects?.cracksOutsideDisplay ?? false,
                onTap: () {
                  final screenDefects =
                      cubit.input.screenDefects ?? ScreenDefects.none;
                  cubit.screenDefectsChanged(
                    screenDefects.copyWith(
                      cracksOutsideDisplay: !screenDefects.cracksOutsideDisplay,
                    ),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.multipleScreenScratches.text,
                image: "assets/images/question/scratch_3.png",
                isSelected: screenDefects?.multipleScratches ?? false,
                onTap: () {
                  final screenDefects =
                      cubit.input.screenDefects ?? ScreenDefects.none;
                  cubit.screenDefectsChanged(
                    screenDefects.copyWith(
                      multipleScratches: !screenDefects.multipleScratches,
                    ),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.minorScreenScratches.text,
                image: "assets/images/question/scratches_4.png",
                isSelected: screenDefects?.minorScratches ?? false,
                onTap: () {
                  final screenDefects =
                      cubit.input.screenDefects ?? ScreenDefects.none;
                  cubit.screenDefectsChanged(
                    screenDefects.copyWith(
                      minorScratches: !screenDefects.minorScratches,
                    ),
                  );
                },
              ),
            ]),
          ],
        ),
      );
    },
  );
}
