import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';

enum DeviceAssessmentStep {
  imei,
  functionality,
  defectsSelection,
  screenDefects,
  displayDefects,
  bodyDefects,
  panelDefects,
  additionalDefects,
  accessories,
  warranty,
  imageUpload,
  complete;

  DeviceAssessmentStep? get next => switch (this) {
    DeviceAssessmentStep.imei => DeviceAssessmentStep.functionality,
    DeviceAssessmentStep.functionality => DeviceAssessmentStep.defectsSelection,
    DeviceAssessmentStep.defectsSelection => DeviceAssessmentStep.screenDefects,
    DeviceAssessmentStep.screenDefects => DeviceAssessmentStep.displayDefects,
    DeviceAssessmentStep.displayDefects => DeviceAssessmentStep.bodyDefects,
    DeviceAssessmentStep.bodyDefects => DeviceAssessmentStep.panelDefects,
    DeviceAssessmentStep.panelDefects => DeviceAssessmentStep.additionalDefects,
    DeviceAssessmentStep.additionalDefects => DeviceAssessmentStep.accessories,
    DeviceAssessmentStep.accessories => DeviceAssessmentStep.warranty,
    DeviceAssessmentStep.warranty => DeviceAssessmentStep.imageUpload,
    DeviceAssessmentStep.imageUpload => DeviceAssessmentStep.complete,
    DeviceAssessmentStep.complete => null,
  };

  Iterable<DeviceAssessmentStep> get stepsAfter sync* {
    DeviceAssessmentStep? nextStep = next;
    while (nextStep != null) {
      yield nextStep;
      nextStep = nextStep.next;
    }
  }
}

class DeviceDefectsSelection {
  const DeviceDefectsSelection({
    required this.screen,
    required this.display,
    required this.body,
    required this.panel,
  });

  static const none = DeviceDefectsSelection(
    screen: false,
    display: false,
    body: false,
    panel: false,
  );

  final bool screen;

  final bool display;

  final bool body;

  final bool panel;

  DeviceDefectsSelection copyWith({
    bool? screen,
    bool? display,
    bool? body,
    bool? panel,
  }) => DeviceDefectsSelection(
    screen: screen ?? this.screen,
    display: display ?? this.display,
    body: body ?? this.body,
    panel: panel ?? this.panel,
  );

  bool filterStep(DeviceAssessmentStep step) => switch (step) {
    DeviceAssessmentStep.screenDefects => screen,
    DeviceAssessmentStep.displayDefects => display,
    DeviceAssessmentStep.bodyDefects => body,
    DeviceAssessmentStep.panelDefects => panel,
    _ => true,
  };
}

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

class DeviceAssessmentInput {
  final Imei? imei;
  final DeviceFunctionality? functionality;
  final DeviceDefectsSelection defects;
  final ScreenDefects? screenDamage;
  final DisplayDefects? displayDefects;
  final BodyDefects? bodyDefects;
  final PanelDefects? panelDefects;
  final AdditionalIssues? additionalIssues;
  final Accessories? accessories;
  final WarrantyPeriod? warrantyPeriod;
  final DeviceImages? images;

  const DeviceAssessmentInput({
    this.imei,
    this.functionality,
    this.defects = DeviceDefectsSelection.none,
    this.screenDamage,
    this.displayDefects,
    this.bodyDefects,
    this.panelDefects,
    this.additionalIssues,
    this.accessories,
    this.warrantyPeriod,
    this.images,
  });

  DeviceAssessmentInput copyWith({
    Imei? imei,
    DeviceFunctionality? functionality,
    ScreenDefects? screenDamage,
    DisplayDefects? displayDefects,
    BodyDefects? bodyDefects,
    PanelDefects? panelDefects,
    AdditionalIssues? additionalIssues,
    Accessories? accessories,
    WarrantyPeriod? warrantyPeriod,
    DeviceImages? images,
  }) {
    return DeviceAssessmentInput(
      imei: imei ?? this.imei,
      functionality: functionality ?? this.functionality,
      screenDamage: screenDamage ?? this.screenDamage,
      displayDefects: displayDefects ?? this.displayDefects,
      bodyDefects: bodyDefects ?? this.bodyDefects,
      panelDefects: panelDefects ?? this.panelDefects,
      additionalIssues: additionalIssues ?? this.additionalIssues,
      accessories: accessories ?? this.accessories,
      warrantyPeriod: warrantyPeriod ?? this.warrantyPeriod,
      images: images ?? this.images,
    );
  }
}
