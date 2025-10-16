import 'package:boilerplate/src/features/questionaire/data/data_sources/local/questionnaire_store.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_assessment_cubit.dart';
import 'package:boilerplate/src/features/questionaire/presentation/models/flow_state.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/widgets/issue_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefectsSelectionPage extends StatelessWidget {
  const DefectsSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DeviceAssessmentCubit>();
    return BlocBuilder<DeviceAssessmentCubit, DeviceAssessmentState>(
      builder: (context, state) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectIssuesHeader(title: "Select device issues"),
          Expanded(
            child: IssueGrid([
              IssueData(
                title: QuestionnaireStore.brokenScratchOnScreen.text,
                image: "assets/images/question/scratch_1.png",
                isSelected: state.input.defects.screen,
                onTap: () {
                  final defects = cubit.input.defects;
                  cubit.defectsSelectionChanged(
                    defects.copyWith(screen: !defects.screen),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.displayDefects.text,
                image: "assets/images/question/lines_1.png",
                isSelected: state.input.defects.display,
                onTap: () {
                  final defects = cubit.input.defects;
                  cubit.defectsSelectionChanged(
                    defects.copyWith(display: !defects.display),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.scratchOrDentOnBody.text,
                image: "assets/images/question/dent_1.png",
                isSelected: state.input.defects.body,
                onTap: () {
                  final defects = cubit.input.defects;
                  cubit.defectsSelectionChanged(
                    defects.copyWith(body: !defects.body),
                  );
                },
              ),
              IssueData(
                title: QuestionnaireStore.devicePanelMissingOrBroken.text,
                image: "assets/images/question/panel_1.png",
                isSelected: state.input.defects.panel,
                onTap: () {
                  final defects = cubit.input.defects;
                  cubit.defectsSelectionChanged(
                    defects.copyWith(panel: !defects.panel),
                  );
                },
              ),
            ]),
          ),
          SizedBox(height: 8.h),
          NoDefectsCheckbox(cubit: cubit),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class SelectIssuesHeader extends StatelessWidget {
  const SelectIssuesHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.h),
        RegularText(
          textAlign: TextAlign.start,
          textSize: 16.sp,
          maxLines: 2,
          fontWeight: FontWeight.w600,
          textColor: AppColors.black,
          textOverflow: TextOverflow.ellipsis,
          text: title,
        ),
        SizedBox(height: 8.h),
        RegularText(
          textAlign: TextAlign.start,
          textSize: 12.sp,
          maxLines: 2,
          fontWeight: FontWeight.w500,
          textColor: AppColors.borderBlack,
          textOverflow: TextOverflow.ellipsis,
          text: "Select all the issues/defects in the device",
        ),

        SizedBox(height: 24.h),
      ],
    );
  }
}

class NoDefectsCheckbox extends StatelessWidget {
  const NoDefectsCheckbox({super.key, required this.cubit});

  final DeviceAssessmentCubit cubit;

  String get imageAsset => cubit.input.ignoreDefects
      ? "assets/images/selected_checkbox.png"
      : "assets/images/question/unchecked_checkbox.png";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            cubit.ignoreDefectsChanged();
          },
          child: Image.asset(imageAsset, width: 24.w, height: 24.h),
        ),

        SizedBox(width: 8.w),
        RegularText(
          textAlign: TextAlign.start,
          textSize: 12.sp,
          maxLines: 2,
          fontWeight: FontWeight.w500,
          textColor: AppColors.borderBlack,
          textOverflow: TextOverflow.ellipsis,
          text: "Device does not have any defects",
        ),
      ],
    );
  }
}

class IssueData {
  final String title;
  final String image;
  final bool isSelected;
  final VoidCallback? onTap;

  IssueData({
    required this.title,
    required this.image,
    required this.isSelected,
    this.onTap,
  });
}

class IssueGrid extends StatelessWidget {
  const IssueGrid(this.data, {super.key});

  final List<IssueData> data;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 12.w,
    runSpacing: 8.h,
    children: [
      for (var item in data)
        SizedBox(
          width: (155.w),
          child: IssueCard(
            title: item.title,
            image: item.image,
            isSelected: item.isSelected,
            onTap: item.onTap,
          ),
        ),
    ],
  );
}

class IssueSection extends StatelessWidget {
  const IssueSection({super.key, required this.title, required this.issues});

  final String title;
  final List<IssueData> issues;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RegularText(
        text: title,
        textSize: 16.sp,
        fontWeight: FontWeight.w600,
        textColor: AppColors.black,
      ),
      SizedBox(height: 24.h),
      IssueGrid(issues),
      SizedBox(height: 24.h),
    ],
  );
}


// Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IssueCard(
//                 title: QuestionnaireStore.cracksOrScratchOnScreen.text,
//                 image: "assets/images/question/scratch_1.png",
//                 isSelected: state.input.defects.screen,
//                 onTap: () {
//                   final defects = cubit.input.defects;
//                   cubit.defectsSelectionChanged(
//                     defects.copyWith(screen: !defects.screen),
//                   );
//                 },
//               ),
//               IssueCard(
//                 title: QuestionnaireStore.displayDefects.text,
//                 image: "assets/images/question/lines_1.png",
//                 isSelected: state.input.defects.display,
//                 onTap: () {
//                   final defects = cubit.input.defects;
//                   cubit.defectsSelectionChanged(
//                     defects.copyWith(display: !defects.display),
//                   );
//                 },
//               ),
//             ],
//           ),
//           SizedBox(height: 8.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IssueCard(
//                 title: QuestionnaireStore.scratchOrDentOnBody.text,
//                 image: "assets/images/question/dent_1.png",
//                 isSelected: state.input.defects.body,
//                 onTap: () {
//                   final defects = cubit.input.defects;
//                   cubit.defectsSelectionChanged(
//                     defects.copyWith(body: !defects.body),
//                   );
//                 },
//               ),
//               IssueCard(
//                 title: QuestionnaireStore.devicePanelMissingOrBroken.text,
//                 image: "assets/images/question/panel_1.png",
//                 isSelected: state.input.defects.panel,
//                 onTap: () {
//                   final defects = cubit.input.defects;
//                   cubit.defectsSelectionChanged(
//                     defects.copyWith(panel: !defects.panel),
//                   );
//                 },
//               ),
//             ],
//           )