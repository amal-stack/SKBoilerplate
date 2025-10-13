import 'package:boilerplate/src/features/questionaire/data/data_sources/local/questionnaire_store.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_assessment_cubit.dart';
import 'package:boilerplate/src/features/questionaire/presentation/models/flow_state.dart';
import 'package:boilerplate/src/features/questionaire/presentation/screen/product_condition_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PanelDefectsPage extends StatelessWidget {
  const PanelDefectsPage({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocSelector<DeviceAssessmentCubit, DeviceAssessmentState, PanelDefects?>(
        selector: (DeviceAssessmentState state) => state.input.panelDefects,
        builder: (context, state) {
          final cubit = context.read<DeviceAssessmentCubit>();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectIssuesHeader(title: "Broken/missing panel"),
                SizedBox(height: 16.h),
               
                SizedBox(height: 24.h),
                IssueSection(
                  title: "Device Side/Back Panel Condition",
                  issues: [
                    IssueData(
                      title: QuestionnaireStore.crackedOrBrokenPanel.text,
                      image: "assets/images/question/scratch_1.png",
                      isSelected: state?.panelDamage == PanelDamage.cracked,
                      onTap: () {
                        final panelDefects =
                            cubit.input.panelDefects ?? PanelDefects.none;
                        cubit.panelDefectsChanged(
                          panelDefects.copyWith(
                            panelDamage: PanelDamage.cracked,
                          ),
                        );
                      },
                    ),
                    IssueData(
                      title: QuestionnaireStore.sideOrBackPanelMissing.text,
                      image: "assets/images/question/lines_1.png",
                      isSelected: state?.panelDamage == PanelDamage.missing,
                      onTap: () {
                        final panelDefects =
                            cubit.input.panelDefects ?? PanelDefects.none;
                        cubit.panelDefectsChanged(
                          panelDefects.copyWith(
                            panelDamage: PanelDamage.missing,
                          ),
                        );
                      },
                    ),
                    IssueData(
                      title: QuestionnaireStore.noDamageOnPanel.text,
                      image: "assets/images/question/scratch_1.png",
                      isSelected: state?.panelDamage == PanelDamage.none,
                      onTap: () {
                        final panelDefects =
                            cubit.input.panelDefects ?? PanelDefects.none;
                        cubit.panelDefectsChanged(
                          panelDefects.copyWith(panelDamage: PanelDamage.none),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                IssueSection(
                  title: "Device Bent/Screen loose",
                  issues: [
                    IssueData(
                      title: QuestionnaireStore.bentOrCurvedFrame.text,
                      image: "assets/images/question/scratch_1.png",
                      isSelected: state?.frameCondition == FrameCondition.bent,
                      onTap: () {
                        final panelDefects =
                            cubit.input.panelDefects ?? PanelDefects.none;
                        cubit.panelDefectsChanged(
                          panelDefects.copyWith(
                            frameCondition: FrameCondition.bent,
                          ),
                        );
                      },
                    ),
                    IssueData(
                      title: QuestionnaireStore.looseBetweenScreenAndBody.text,
                      image: "assets/images/question/lines_1.png",
                      isSelected: state?.frameCondition == FrameCondition.loose,
                      onTap: () {
                        final panelDefects =
                            cubit.input.panelDefects ?? PanelDefects.none;
                        cubit.panelDefectsChanged(
                          panelDefects.copyWith(
                            frameCondition: FrameCondition.loose,
                          ),
                        );
                      },
                    ),
                    IssueData(
                      title: QuestionnaireStore.frameIsStraight.text,
                      image: "assets/images/question/scratch_1.png",
                      isSelected: state?.frameCondition.isDefective ?? false,
                      onTap: () {
                        final panelDefects =
                            cubit.input.panelDefects ?? PanelDefects.none;
                        cubit.panelDefectsChanged(
                          panelDefects.copyWith(
                            frameCondition: FrameCondition.straight,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
              ],
            ),
          );
        },
      );
}
