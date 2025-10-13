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

class DisplayDefectsPage extends StatelessWidget {
  const DisplayDefectsPage({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<DeviceAssessmentCubit, DeviceAssessmentState>(
    builder: (context, state) {
      final displayDefects = state.input.displayDefects;
      final cubit = context.read<DeviceAssessmentCubit>();
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            // Section: Dead Pixels / Spots
            RegularText(
              text: "Display defects (Spots/Lines)",
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
            RegularText(
              text: "Dead Pixels or Spots",
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
              textColor: AppColors.black,
            ),
            SizedBox(height: 24.h),
            IssueGrid([
              IssueData(
                title: QuestionnaireStore.largeOrHeavyVisibleSpots.text,
                image: "assets/images/question/scratch_1.png",
                isSelected: displayDefects?.spots == DisplaySpots.largeHeavy,
                onTap: () {
                  final displayDefects =
                      cubit.input.displayDefects ?? DisplayDefects.none;
                  cubit.displayDefectsChanged(
                    displayDefects.copyWith(spots: DisplaySpots.largeHeavy),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.threeOrMoreSmallSpots.text,
                image: "assets/images/question/lines_1.png",
                isSelected:
                    displayDefects?.spots == DisplaySpots.threeOrMoreSmall,
                onTap: () {
                  final displayDefects =
                      cubit.input.displayDefects ?? DisplayDefects.none;
                  cubit.displayDefectsChanged(
                    displayDefects.copyWith(
                      spots: DisplaySpots.threeOrMoreSmall,
                    ),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.oneOrTwoSmallSpots.text,
                image: "assets/images/question/scratch_1.png",
                isSelected: displayDefects?.spots == DisplaySpots.oneOrTwoSmall,
                onTap: () {
                  final displayDefects =
                      cubit.input.displayDefects ?? DisplayDefects.none;
                  cubit.displayDefectsChanged(
                    displayDefects.copyWith(spots: DisplaySpots.oneOrTwoSmall),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.noSpotsOnScreen.text,
                image: "assets/images/question/lines_1.png",
                isSelected: displayDefects?.spots == DisplaySpots.none,
                onTap: () {
                  final displayDefects =
                      cubit.input.displayDefects ?? DisplayDefects.none;
                  cubit.displayDefectsChanged(
                    displayDefects.copyWith(spots: DisplaySpots.none),
                  );
                },
              ),
            ]),
            SizedBox(height: 24.h),
            // Section: Visible Lines
            RegularText(
              text: "Visible Lines",
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
              textColor: AppColors.black,
            ),
            SizedBox(height: 24.h),
            IssueGrid([
              IssueData(
                title: QuestionnaireStore.visibleLinesOnScreen.text,
                image: "assets/images/question/scratch_1.png",
                isSelected: displayDefects?.lines == DisplayLines.hasVisible,
                onTap: () {
                  final displayDefects =
                      cubit.input.displayDefects ?? DisplayDefects.none;
                  cubit.displayDefectsChanged(
                    displayDefects.copyWith(lines: DisplayLines.hasVisible),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.fadedDisplayEdges.text,
                image: "assets/images/question/lines_1.png",
                isSelected: displayDefects?.lines == DisplayLines.fadedEdges,
                onTap: () {
                  final displayDefects =
                      cubit.input.displayDefects ?? DisplayDefects.none;
                  cubit.displayDefectsChanged(
                    displayDefects.copyWith(lines: DisplayLines.fadedEdges),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.noLinesOnScreen.text,
                image: "assets/images/question/lines_1.png",
                isSelected: displayDefects?.lines == DisplayLines.none,
                onTap: () {
                  final displayDefects =
                      cubit.input.displayDefects ?? DisplayDefects.none;
                  cubit.displayDefectsChanged(
                    displayDefects.copyWith(lines: DisplayLines.none),
                  );
                },
              ),
            ]),
            SizedBox(height: 24.h),
            // Section: Screen Discoloration
            RegularText(
              text: "Screen Discoloration",
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
              textColor: AppColors.black,
            ),
            SizedBox(height: 24.h),
            IssueGrid([
              IssueData(
                title: QuestionnaireStore.severeDiscoloration.text,
                image: "assets/images/question/scratch_1.png",
                isSelected:
                    displayDefects?.discoloration == Discoloration.severe,
                onTap: () {
                  final displayDefects =
                      cubit.input.displayDefects ?? DisplayDefects.none;
                  cubit.displayDefectsChanged(
                    displayDefects.copyWith(
                      discoloration: Discoloration.severe,
                    ),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.minorDiscoloration.text,
                image: "assets/images/question/lines_1.png",
                isSelected:
                    displayDefects?.discoloration == Discoloration.minor,
                onTap: () {
                  final displayDefects =
                      cubit.input.displayDefects ?? DisplayDefects.none;
                  cubit.displayDefectsChanged(
                    displayDefects.copyWith(discoloration: Discoloration.minor),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.noDiscoloration.text,
                image: "assets/images/question/scratch_1.png",
                isSelected: displayDefects?.discoloration == Discoloration.none,
                onTap: () {
                  final displayDefects =
                      cubit.input.displayDefects ?? DisplayDefects.none;
                  cubit.displayDefectsChanged(
                    displayDefects.copyWith(discoloration: Discoloration.none),
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
