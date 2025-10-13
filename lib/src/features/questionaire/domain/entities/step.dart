enum DeviceAssessmentStep {
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


  static const first = DeviceAssessmentStep.functionality;

  static const last = DeviceAssessmentStep.imageUpload;

  DeviceAssessmentStep? get next => switch (this) {
    
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

  DeviceAssessmentStep? get previous => switch (this) {
    DeviceAssessmentStep.functionality => null,
    DeviceAssessmentStep.defectsSelection => DeviceAssessmentStep.functionality,
    DeviceAssessmentStep.screenDefects => DeviceAssessmentStep.defectsSelection,
    DeviceAssessmentStep.displayDefects => DeviceAssessmentStep.screenDefects,
    DeviceAssessmentStep.bodyDefects => DeviceAssessmentStep.displayDefects,
    DeviceAssessmentStep.panelDefects => DeviceAssessmentStep.bodyDefects,
    DeviceAssessmentStep.additionalDefects => DeviceAssessmentStep.panelDefects,
    DeviceAssessmentStep.accessories => DeviceAssessmentStep.additionalDefects,
    DeviceAssessmentStep.warranty => DeviceAssessmentStep.accessories,
    DeviceAssessmentStep.imageUpload => DeviceAssessmentStep.warranty,
    DeviceAssessmentStep.complete => DeviceAssessmentStep.imageUpload,
  };

  Iterable<DeviceAssessmentStep> get stepsAfter sync* {
    DeviceAssessmentStep? nextStep = next;
    while (nextStep != null) {
      yield nextStep;
      nextStep = nextStep.next;
    }
  }

  Iterable<DeviceAssessmentStep> get stepsBefore sync* {
    DeviceAssessmentStep? previousStep = previous;
    while (previousStep != null) {
      yield previousStep;
      previousStep = previousStep.previous;
    }
  }
}
