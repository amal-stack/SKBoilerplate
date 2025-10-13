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

class BodyDefectsPage extends StatelessWidget {
  const BodyDefectsPage({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<DeviceAssessmentCubit, DeviceAssessmentState>(
    builder: (context, state) {
      final cubit = context.read<DeviceAssessmentCubit>();
      final bodyDefects = state.input.bodyDefects;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            RegularText(
              text: "Scratches/dents on the device",
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
              textColor: AppColors.black,
            ),
            SizedBox(height: 8.h),
            RegularText(
              text: "Select all the issues/defects in the device",
              textSize: 12.sp,
              fontWeight: FontWeight.w500,
              textColor: AppColors.borderBlack,
            ),
            SizedBox(height: 16.h),
            // Scratches section
            RegularText(
              text: "Scratches",
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
              textColor: AppColors.black,
            ),
            SizedBox(height: 24.h),
            IssueGrid([
              IssueData(
                title: QuestionnaireStore.moreThanTwoBodyScratches.text,
                image: "assets/images/question/dent_sub_1.png",
                isSelected: bodyDefects?.scratches == ScratchSeverity.moreThanTwo,
                onTap: () {
                  final bodyDefects = cubit.input.bodyDefects ?? BodyDefects.none;
                  cubit.bodyDefectsChanged(
                    bodyDefects.copyWith(scratches: ScratchSeverity.moreThanTwo),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.oneOrTwoBodyScratches.text,
                image: "assets/images/question/dent_sub_2.png",
                isSelected: bodyDefects?.scratches == ScratchSeverity.oneOrTwo,
                onTap: () {
                  final bodyDefects = cubit.input.bodyDefects ?? BodyDefects.none;
                  cubit.bodyDefectsChanged(
                    bodyDefects.copyWith(scratches: ScratchSeverity.oneOrTwo),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.noBodyScratches.text,
                image: "assets/images/question/dent_sub_3.png",
                isSelected: bodyDefects?.scratches.hasScratches ?? false,
                onTap: () {
                  final bodyDefects = cubit.input.bodyDefects ?? BodyDefects.none;
                  cubit.bodyDefectsChanged(
                    bodyDefects.copyWith(scratches: ScratchSeverity.none),
                  );
                },
              ),
            ]),
            SizedBox(height: 24.h),
            // Dents section
            RegularText(
              text: "Dents",
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
              textColor: AppColors.black,
            ),
            SizedBox(height: 24.h),
            IssueGrid([
              IssueData(
                title: QuestionnaireStore.multipleDents.text,
                image: "assets/images/question/dent_sub_4.png",
                isSelected: bodyDefects?.dents == DentSeverity.multiple,
                onTap: () {
                  final bodyDefects = cubit.input.bodyDefects ?? BodyDefects.none;
                  cubit.bodyDefectsChanged(
                    bodyDefects.copyWith(dents: DentSeverity.multiple),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.oneOrTwoMinorDents.text,
                image: "assets/images/question/dent_sub_5.png",
                isSelected: bodyDefects?.dents == DentSeverity.oneOrTwoMinor,
                onTap: () {
                  final bodyDefects = cubit.input.bodyDefects ?? BodyDefects.none;
                  cubit.bodyDefectsChanged(
                    bodyDefects.copyWith(dents: DentSeverity.oneOrTwoMinor),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.noDents.text,
                image: "assets/images/question/dent_sub_6.png",
                isSelected: bodyDefects?.dents.hasDents ?? false,
                onTap: () {
                  final bodyDefects = cubit.input.bodyDefects ?? BodyDefects.none;
                  cubit.bodyDefectsChanged(
                    bodyDefects.copyWith(dents: DentSeverity.none),
                  );
                },
              ),
            ]),
            SizedBox(height: 50.h),
          ],
        ),
      );
    },
  );
}
