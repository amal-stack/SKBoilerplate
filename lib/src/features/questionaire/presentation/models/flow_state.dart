import 'package:boilerplate/src/features/questionaire/presentation/models/input.dart';
import 'package:boilerplate/src/features/questionaire/presentation/models/step.dart';

class DeviceAssessmentFlowState {
  final DeviceAssessmentStep currentStep;
  final DeviceAssessmentInput input;

  const DeviceAssessmentFlowState({
    required this.currentStep,
    required this.input,
  });

  static const initial = DeviceAssessmentFlowState(
    currentStep: DeviceAssessmentStep.imei,
    input: DeviceAssessmentInput(),
  );

  DeviceAssessmentStep? get nextStep =>
      currentStep.stepsAfter.where(input.defects.filterStep).firstOrNull;

  DeviceAssessmentFlowState copyWith({
    DeviceAssessmentStep? currentStep,
    DeviceAssessmentInput? input,
  }) => DeviceAssessmentFlowState(
    currentStep: currentStep ?? this.currentStep,
    input: input ?? this.input,
  );

  DeviceAssessmentFlowState withInput(DeviceAssessmentInput newInput) =>
      DeviceAssessmentFlowState(currentStep: currentStep, input: newInput);

  DeviceAssessmentFlowState withStep(DeviceAssessmentStep newStep) =>
      DeviceAssessmentFlowState(currentStep: newStep, input: input);

  DeviceAssessmentFlowState withNextStep() => DeviceAssessmentFlowState(
    currentStep: nextStep ?? currentStep,
    input: input,
  );
}
