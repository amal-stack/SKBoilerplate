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
