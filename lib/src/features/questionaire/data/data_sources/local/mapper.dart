import 'package:boilerplate/src/features/questionaire/data/data_sources/local/questionnaire_store.dart';
import 'package:boilerplate/src/features/questionaire/data/models/response.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';

abstract final class DomainToAssessmentResponseMapper {
  static List<AssessmentQuestionResponse> deviceFunctionality(
    DeviceFunctionality functionality,
  ) => [
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.makeReceiveCalls.id,
      response: functionality.canMakeReceiveCalls,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.touchScreenWorking.id,
      response: functionality.touchWorking,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.screenOriginal.id,
      response: functionality.screenOriginal,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.deviceUnderWarranty.id,
      response: functionality.underWarranty,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.gstBillWithImei.id,
      response: functionality.hasGstBill,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.esimsSupported.id,
      response: functionality.esimSupported,
    ),
  ];

  static List<AssessmentQuestionResponse> defects(
    DeviceDefectsSelection defects,
  ) => [
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.cracksOrScratchOnScreen.id,
      response: defects.screen,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.displayDefects.id,
      response: defects.display,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.scratchOrDentOnBody.id,
      response: defects.body,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.devicePanelMissingOrBroken.id,
      response: defects.panel,
    ),
  ];

  static List<AssessmentQuestionResponse> screenDefects(
    ScreenDefects defects,
  ) => [
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.crackedScreenOrBrokenGlass.id,
      response: defects.crackedGlass,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.cracksOutsideDisplayArea.id,
      response: defects.cracksOutsideDisplay,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.multipleScreenScratches.id,
      response: defects.multipleScratches,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.minorScreenScratches.id,
      response: defects.minorScratches,
    ),
  ];

  static List<AssessmentQuestionResponse> displayDefects(
    DisplayDefects defects,
  ) => [
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.largeOrHeavyVisibleSpots.id,
      response: defects.spots == DisplaySpots.largeHeavy,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.threeOrMoreSmallSpots.id,
      response: defects.spots == DisplaySpots.threeOrMoreSmall,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.oneOrTwoSmallSpots.id,
      response: defects.spots == DisplaySpots.oneOrTwoSmall,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.noSpotsOnScreen.id,
      response: defects.spots == DisplaySpots.none,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.visibleLinesOnScreen.id,
      response: defects.lines == DisplayLines.hasVisible,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.fadedDisplayEdges.id,
      response: defects.lines == DisplayLines.fadedEdges,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.noLinesOnScreen.id,
      response: defects.lines == DisplayLines.none,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.severeDiscoloration.id,
      response: defects.discoloration == Discoloration.severe,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.minorDiscoloration.id,
      response: defects.discoloration == Discoloration.minor,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.noDiscoloration.id,
      response: defects.discoloration == Discoloration.none,
    ),
  ];

  static List<AssessmentQuestionResponse> bodyDefects(BodyDefects defects) => [
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.moreThanTwoBodyScratches.id,
      response: defects.scratches == ScratchSeverity.moreThanTwo,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.oneOrTwoBodyScratches.id,
      response: defects.scratches == ScratchSeverity.oneOrTwo,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.noBodyScratches.id,
      response: defects.scratches == ScratchSeverity.none,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.multipleDents.id,
      response: defects.dents == DentSeverity.multiple,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.oneOrTwoMinorDents.id,
      response: defects.dents == DentSeverity.oneOrTwoMinor,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.noDents.id,
      response: defects.dents == DentSeverity.none,
    ),
  ];

  static List<AssessmentQuestionResponse> panelDefects(PanelDefects defects) =>
      [
        AssessmentQuestionResponse(
          questionId: QuestionnaireStore.crackedOrBrokenPanel.id,
          response: defects.panelDamage == PanelDamage.cracked,
        ),
        AssessmentQuestionResponse(
          questionId: QuestionnaireStore.sideOrBackPanelMissing.id,
          response: defects.panelDamage == PanelDamage.missing,
        ),
        AssessmentQuestionResponse(
          questionId: QuestionnaireStore.noDamageOnPanel.id,
          response: defects.panelDamage == PanelDamage.none,
        ),
        AssessmentQuestionResponse(
          questionId: QuestionnaireStore.bentOrCurvedFrame.id,
          response: defects.frameCondition == FrameCondition.bent,
        ),
        AssessmentQuestionResponse(
          questionId: QuestionnaireStore.looseBetweenScreenAndBody.id,
          response: defects.frameCondition == FrameCondition.loose,
        ),
        AssessmentQuestionResponse(
          questionId: QuestionnaireStore.frameIsStraight.id,
          response: defects.frameCondition == FrameCondition.straight,
        ),
      ];

  static List<AssessmentQuestionResponse> additionalIssues(
    AdditionalIssues issues,
  ) => [
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.frontCameraNotWorking.id,
      response: issues.hasIssue(AdditionalIssue.frontCamera),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.rearCameraNotWorking.id,
      response: issues.hasIssue(AdditionalIssue.rearCamera),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.volumeButtonsUnresponsive.id,
      response: issues.hasIssue(AdditionalIssue.volumeButtons),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.fingerprintSensorNotWorking.id,
      response: issues.hasIssue(AdditionalIssue.fingerprintSensor),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.wifiNotConnecting.id,
      response: issues.hasIssue(AdditionalIssue.wifi),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.speakerMalfunctioning.id,
      response: issues.hasIssue(AdditionalIssue.speaker),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.silentSwitchNotWorking.id,
      response: issues.hasIssue(AdditionalIssue.silentSwitch),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.faceRecognitionNotWorking.id,
      response: issues.hasIssue(AdditionalIssue.faceRecognition),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.powerButtonUnresponsive.id,
      response: issues.hasIssue(AdditionalIssue.powerButton),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.chargingPortNotWorking.id,
      response: issues.hasIssue(AdditionalIssue.chargingPort),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.audioReceiverFaulty.id,
      response: issues.hasIssue(AdditionalIssue.audioReceiver),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.cameraGlassBroken.id,
      response: issues.hasIssue(AdditionalIssue.cameraGlass),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.microphoneNotWorking.id,
      response: issues.hasIssue(AdditionalIssue.microphone),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.bluetoothNotConnecting.id,
      response: issues.hasIssue(AdditionalIssue.bluetooth),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.vibrationMotorNotWorking.id,
      response: issues.hasIssue(AdditionalIssue.vibrationMotor),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.proximitySensorNotFunctioning.id,
      response: issues.hasIssue(AdditionalIssue.proximitySensor),
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.batteryRequiresService.id,
      response: issues.batteryHealth == BatteryHealth.below80,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.batteryHealth80To85.id,
      response: issues.batteryHealth == BatteryHealth.from80to85,
    ),
  ];

  static List<AssessmentQuestionResponse> accessories(
    Accessories accessories,
  ) => [
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.originalCharger.id,
      response: accessories.originalCharger,
    ),
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.originalBox.id,
      response: accessories.originalBox,
    ),
  ];

  static List<AssessmentQuestionResponse> warranty(WarrantyPeriod warranty) => [
    AssessmentQuestionResponse(
      questionId: QuestionnaireStore.deviceUnderWarrantyDuplicate.id,
      response: warranty.isInWarranty,
    ),
  ];

  static List<AssessmentQuestionResponse> assessment(
    DeviceAssessment assessment,
  ) => [
    ...deviceFunctionality(assessment.functionality),
    ...defects(assessment.defects),
    ...screenDefects(assessment.screenDefects),
    ...displayDefects(assessment.displayDefects),
    ...bodyDefects(assessment.bodyDefects),
    ...panelDefects(assessment.panelDefects),
    ...additionalIssues(assessment.additionalIssues),
    ...accessories(assessment.accessories),
    ...warranty(assessment.warrantyPeriod),
  ];
}
