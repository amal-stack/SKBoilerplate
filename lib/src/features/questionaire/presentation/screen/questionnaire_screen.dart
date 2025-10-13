import 'package:boilerplate/src/features/questionaire/domain/entities/step.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_assessment_cubit.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_images_upload_cubit.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_invoice_upload_cubit.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/questionnaire_cubit.dart';
import 'package:boilerplate/src/features/questionaire/presentation/models/flow_state.dart';
import 'package:boilerplate/src/features/questionaire/presentation/screen/additional_issues_page.dart';
import 'package:boilerplate/src/features/questionaire/presentation/screen/available_accessories_page.dart';
import 'package:boilerplate/src/features/questionaire/presentation/screen/body_defects_page.dart';
import 'package:boilerplate/src/features/questionaire/presentation/screen/device_functionality_page.dart';
import 'package:boilerplate/src/features/questionaire/presentation/screen/display_defects_page.dart';
import 'package:boilerplate/src/features/questionaire/presentation/screen/panel_defects_page.dart';
import 'package:boilerplate/src/features/questionaire/presentation/screen/product_condition_screen.dart';
import 'package:boilerplate/src/features/questionaire/presentation/screen/scratch_selection_page.dart';
import 'package:boilerplate/src/features/questionaire/presentation/screen/upload_device_image_page.dart';
import 'package:boilerplate/src/features/questionaire/presentation/screen/warranty_selection_page.dart';
import 'package:boilerplate/src/features/questionaire/presentation/widgets/continue_button.dart';
import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/themes/text.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key, required this.quoteId});

  final String quoteId;

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => DeviceAssessmentCubit(context.read())),
      BlocProvider(create: (context) => QuestionnaireCubit(context.read())),
      BlocProvider(
        create: (context) => DeviceImagesUploadCubit(context.read()),
      ),
      BlocProvider(
        create: (context) => DeviceInvoiceUploadCubit(context.read()),
      ),
    ],
    child: MultiBlocListener(
      listeners: [
        BlocListener<DeviceAssessmentCubit, DeviceAssessmentState>(
          listenWhen: (previous, current) => previous.step != current.step,
          listener: (context, state) {
            switch (state) {
              case DeviceAssessmentCompleted completed:
                context.go('/device-value', extra: completed.result);
              case DeviceAssessmentError error:
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(error.message)));
              default:
            }
          },
        ),
        BlocListener<DeviceImagesUploadCubit, DeviceImagesUploadState>(
          listener: (context, state) {
            switch (state.viewState) {
              case ViewError():
                final message = (state.viewState as ViewError).message;
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              case ViewSuccess():
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Images uploaded successfully")),
                );
              default:
                break;
            }
          },
        ),
        BlocListener<DeviceInvoiceUploadCubit, DeviceInvoiceState>(
          listener: (context, state) {
            switch (state.viewState) {
              case ViewError():
                final message = (state.viewState as ViewError).message;
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              case ViewSuccess(:final data):
                if (!data) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to upload invoice")),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Invoice uploaded successfully"),
                  ),
                );
              default:
                break;
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          leading: QuestionnaireBackButton(),
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
                Expanded(child: CurrentStepPage()),
                ContinueButton(quoteId: widget.quoteId),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class CurrentStepPage extends StatelessWidget {
  const CurrentStepPage({super.key});

  static const pages = {
    DeviceAssessmentStep.functionality: DeviceFunctionalityPage(),
    DeviceAssessmentStep.defectsSelection: DefectsSelectionPage(),
    DeviceAssessmentStep.screenDefects: ScratchSelectionPage(),
    DeviceAssessmentStep.displayDefects: DisplayDefectsPage(),
    DeviceAssessmentStep.bodyDefects: BodyDefectsPage(),
    DeviceAssessmentStep.panelDefects: PanelDefectsPage(),
    DeviceAssessmentStep.additionalDefects: AdditionalIssuesPage(),
    DeviceAssessmentStep.accessories: AvailableAccessoriesPage(),
    DeviceAssessmentStep.warranty: WarrantySelectionPage(),
    DeviceAssessmentStep.imageUpload: UploadDeviceImagePage(),
  };

  @override
  Widget build(BuildContext context) {
    Widget transitionBuilder(Widget child, Animation<double> animation) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        ),
      );
    }

    return BlocSelector<
      DeviceAssessmentCubit,
      DeviceAssessmentState,
      DeviceAssessmentStep
    >(
      selector: (state) => state.step,

      builder: (context, step) => AnimatedSwitcher(
        duration: Durations.medium2,
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: transitionBuilder,
        layoutBuilder: (currentChild, previousChildren) => Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            //...previousChildren,
            if (currentChild != null) currentChild,
          ],
        ),
        child: KeyedSubtree(
          key: ValueKey(step),
          child: pages[step] ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}

class QuestionnaireBackButton extends StatelessWidget {
  const QuestionnaireBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: Image.asset(
          "assets/images/left_arrow.png",
          width: 24.w,
          height: 24.h,
          fit: BoxFit.contain,
        ),
      ),
      onPressed: () {
        final cubit = context.read<DeviceAssessmentCubit>();
        if (cubit.state.flow.previousStep == null) {
          context.pop();
          return;
        }
        cubit.previousStep();
      },
    );
  }
}
