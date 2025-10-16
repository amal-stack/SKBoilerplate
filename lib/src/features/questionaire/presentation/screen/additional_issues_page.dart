import 'package:boilerplate/src/features/products/domain/product_variant.dart';
import 'package:boilerplate/src/features/questionaire/data/data_sources/local/questionnaire_store.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_assessment_cubit.dart';
import 'package:boilerplate/src/features/questionaire/presentation/models/flow_state.dart';
import 'package:boilerplate/src/features/questionaire/presentation/screen/product_condition_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdditionalIssuesPage extends StatelessWidget {
  const AdditionalIssuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      DeviceAssessmentCubit,
      DeviceAssessmentState,
      AdditionalIssues?
    >(
      selector: (state) => state.input.additionalIssues,
      builder: (context, state) {
        final cubit = context.read<DeviceAssessmentCubit>();

        void toggleDeviceIssue(AdditionalIssue issue) {
          final additionalIssues =
              cubit.input.additionalIssues ?? AdditionalIssues.none;
          cubit.additionalIssuesChanged(
            additionalIssues.withIssueToggled(issue),
          );
        }

        void updateBatteryHealth(BatteryHealth newHealth) {
          final additionalIssues =
              cubit.input.additionalIssues ?? AdditionalIssues.none;
          final currentHealth = additionalIssues.batteryHealth;

          cubit.additionalIssuesChanged(
            additionalIssues.copyWith(
              batteryHealth: currentHealth == newHealth
                  ? BatteryHealth.healthy
                  : newHealth,
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30.h),
              IssueSection(
                title: "Additional Device Issues",
                issues: [
                  for (final data in additionalIssueData.entries)
                    IssueData(
                      title: data.value.question.text,
                      image: data.value.image,
                      isSelected: state?.hasIssue(data.key) ?? false,
                      onTap: () {
                        toggleDeviceIssue(data.key);
                      },
                    ),
                ],
              ),
              SizedBox(height: 24.h),
              if (cubit.deviceCategory == DeviceCategory.ios)
              IssueSection(
                title: "Battery Health",
                issues: [
                  IssueData(
                    title: QuestionnaireStore.batteryRequiresService.text,
                    image: "assets/images/question/battery_1.png",
                    isSelected: state?.batteryHealth == BatteryHealth.below80,
                    onTap: () {
                      updateBatteryHealth(BatteryHealth.below80);
                    },
                  ),
                  IssueData(
                    title: QuestionnaireStore.batteryHealth80To85.text,
                    image: "assets/images/question/battery_2.png",
                    isSelected: state?.batteryHealth == BatteryHealth.from80to85,
                    onTap: () {
                      updateBatteryHealth(BatteryHealth.from80to85);
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
}

typedef AdditionalIssueData = ({AssessmentQuestion question, String image});

const additionalIssueData = {
  AdditionalIssue.frontCamera: (
    question: QuestionnaireStore.frontCameraNotWorking,
    image: "assets/images/question/additional_1.png",
  ),
  AdditionalIssue.rearCamera: (
    question: QuestionnaireStore.rearCameraNotWorking,
    image: "assets/images/question/additional_2.png",
  ),
  AdditionalIssue.volumeButtons: (
    question: QuestionnaireStore.volumeButtonsUnresponsive,
    image: "assets/images/question/scratch_1.png",
  ),
  AdditionalIssue.fingerprintSensor: (
    question: QuestionnaireStore.fingerprintSensorNotWorking,
    image: "assets/images/question/additional_4.png",
  ),
  AdditionalIssue.wifi: (
    question: QuestionnaireStore.wifiNotConnecting,
    image: "assets/images/question/additional_5.png",
  ),
  AdditionalIssue.speaker: (
    question: QuestionnaireStore.speakerMalfunctioning,
    image: "assets/images/question/scratch_1.png",
  ),
  AdditionalIssue.silentSwitch: (
    question: QuestionnaireStore.silentSwitchNotWorking,
    image: "assets/images/question/scratch_1.png",
  ),
  AdditionalIssue.faceRecognition: (
    question: QuestionnaireStore.faceRecognitionNotWorking,
    image: "assets/images/question/additioal_8.png",
  ),
  AdditionalIssue.powerButton: (
    question: QuestionnaireStore.powerButtonUnresponsive,
    image: "assets/images/question/scratch_1.png",
  ),
  // AdditionalIssue.chargingPort: (
  //   question: QuestionnaireStore.charg,
  //   image: "assets/images/question/scratch_1.png",
  // ),
  AdditionalIssue.audioReceiver: (
    question: QuestionnaireStore.audioReceiverFaulty,
    image: "assets/images/question/additional_11.png",
  ),
  AdditionalIssue.cameraGlass: (
    question: QuestionnaireStore.cameraGlassBroken,
    image: "assets/images/question/additional_12.png",
  ),
  AdditionalIssue.microphone: (
    question: QuestionnaireStore.microphoneNotWorking,
    image: "assets/images/question/additional_13.png",
  ),
  AdditionalIssue.bluetooth: (
    question: QuestionnaireStore.bluetoothNotConnecting,
    image: "assets/images/question/additional_14.png",
  ),
  AdditionalIssue.vibrationMotor: (
    question: QuestionnaireStore.vibrationMotorNotWorking,
    image: "assets/images/question/additional_15.png",
  ),
  AdditionalIssue.proximitySensor: (
    question: QuestionnaireStore.proximitySensorNotFunctioning,
    image: "assets/images/question/additional_16.png",
  ),
};
