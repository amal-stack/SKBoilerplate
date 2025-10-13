import 'package:boilerplate/src/features/questionaire/domain/entities/device_grade.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/presentation/models/input.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/step.dart';

sealed class DeviceAssessmentState {
  const DeviceAssessmentState(this.flow);

  const factory DeviceAssessmentState.initial(DeviceAssessmentFlowState flow) =
      DeviceAssessmentInitial;

  const factory DeviceAssessmentState.inProgress(
    DeviceAssessmentFlowState flow,
  ) = DeviceAssessmentInProgress;

  const factory DeviceAssessmentState.submitting(
    DeviceAssessmentFlowState flow,
  ) = DeviceAssessmentSubmitting;

  const factory DeviceAssessmentState.error(
    DeviceAssessmentFlowState flow, {
    required String message,
  }) = DeviceAssessmentError;

  const factory DeviceAssessmentState.completed(
    DeviceAssessmentFlowState flow, {
    required DeviceGrade grade,
  }) = DeviceAssessmentCompleted;

  final DeviceAssessmentFlowState flow;

  DeviceAssessmentInput get input => flow.input;

  DeviceAssessmentStep get step => flow.currentStep;

  DeviceAssessmentState withInput(DeviceAssessmentInput newInput) =>
      DeviceAssessmentState.inProgress(flow.withInput(newInput));

  DeviceAssessmentState withStep(DeviceAssessmentStep newStep) =>
      DeviceAssessmentState.inProgress(flow.withStep(newStep));

  DeviceAssessmentState withNextStep() =>
      DeviceAssessmentState.inProgress(flow.withNextStep());

  DeviceAssessmentState withPreviousStep() =>
      DeviceAssessmentState.inProgress(flow.withPreviousStep());
}

class DeviceAssessmentInitial extends DeviceAssessmentState {
  const DeviceAssessmentInitial([
    super.flow = DeviceAssessmentFlowState.initial,
  ]);
}

class DeviceAssessmentInProgress extends DeviceAssessmentState {
  const DeviceAssessmentInProgress(super.flow);
}

class DeviceAssessmentSubmitting extends DeviceAssessmentState {
  const DeviceAssessmentSubmitting(super.flow);
}

class DeviceAssessmentError extends DeviceAssessmentState {
  const DeviceAssessmentError(super.flow, {required this.message});

  final String message;
}

class DeviceAssessmentCompleted extends DeviceAssessmentState {
  const DeviceAssessmentCompleted(super.flow, {required this.grade});

  final DeviceGrade grade;
}

class DeviceAssessmentFlowState {
  final DeviceAssessmentStep currentStep;
  final DeviceAssessmentInput input;

  const DeviceAssessmentFlowState({
    required this.currentStep,
    required this.input,
  });

  static const initial = DeviceAssessmentFlowState(
    currentStep: DeviceAssessmentStep.first,
    input: DeviceAssessmentInput(),
  );


  DeviceAssessmentStep? get nextStep =>
      currentStep.stepsAfter.where(input.defects.filterStep).firstOrNull;

  DeviceAssessmentStep? get previousStep =>
      currentStep.stepsBefore.where(input.defects.filterStep).firstOrNull;

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

  DeviceAssessmentFlowState withPreviousStep() => DeviceAssessmentFlowState(
    currentStep: previousStep ?? currentStep,
    input: input,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceAssessmentFlowState &&
          runtimeType == other.runtimeType &&
          currentStep == other.currentStep &&
          input == other.input;

  @override
  int get hashCode => Object.hash(currentStep, input);
}

extension on DeviceDefectsSelection {
  bool filterStep(DeviceAssessmentStep step) => switch (step) {
    DeviceAssessmentStep.screenDefects => screen,
    DeviceAssessmentStep.displayDefects => display,
    DeviceAssessmentStep.bodyDefects => body,
    DeviceAssessmentStep.panelDefects => panel,
    _ => true,
  };
}
