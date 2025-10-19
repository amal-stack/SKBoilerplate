import 'package:boilerplate/src/features/questionaire/data/data_sources/local/questionnaire_store.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/step.dart';

class DeviceAssessmentInput {
  final Imei? imei;
  final DeviceFunctionalityInput functionality;
  final bool ignoreDefects;
  final DeviceDefectsSelection defects;
  final ScreenDefects? screenDefects;
  final DisplayDefects? displayDefects;
  final BodyDefects? bodyDefects;
  final PanelDefects? panelDefects;
  final AdditionalIssues additionalIssues;
  final Accessories accessories;
  final WarrantyPeriod warrantyPeriod;
  final DeviceImages? images;

  const DeviceAssessmentInput({
    this.imei,
    this.functionality = DeviceFunctionalityInput.empty,
    this.ignoreDefects = false,
    this.defects = DeviceDefectsSelection.none,
    this.screenDefects,
    this.displayDefects,
    this.bodyDefects,
    this.panelDefects,
    this.additionalIssues = AdditionalIssues.none,
    this.accessories = Accessories.none,
    this.warrantyPeriod = WarrantyPeriod.outOfWarranty,
    this.images,
  });

  static const empty = DeviceAssessmentInput();

  static T _checkNotNull<T>(T? value, DeviceAssessmentStep step) =>
      DeviceAssessmentInputException.checkStepNotNull(value, step);

  DeviceAssessment toAssessment() {
    final functionalityValue = _checkNotNull(
      functionality,
      DeviceAssessmentStep.functionality,
    ).toFunctionality();

    final DeviceDefectsSelection defectsValue = ignoreDefects
        ? DeviceDefectsSelection.none
        : _checkNotNull(defects, DeviceAssessmentStep.defectsSelection);

    final ScreenDefects screenDefectsValue;
    final DisplayDefects displayDefectsValue;
    final BodyDefects bodyDefectsValue;
    final PanelDefects panelDefectsValue;

    if (defectsValue == DeviceDefectsSelection.none) {
      screenDefectsValue = ScreenDefects.none;
      displayDefectsValue = DisplayDefects.none;
      bodyDefectsValue = BodyDefects.none;
      panelDefectsValue = PanelDefects.none;
    } else {
      screenDefectsValue = defects.screen
          ? _checkNotNull(screenDefects, DeviceAssessmentStep.screenDefects)
          : ScreenDefects.none;
      displayDefectsValue = defects.display
          ? _checkNotNull(displayDefects, DeviceAssessmentStep.displayDefects)
          : DisplayDefects.none;
      bodyDefectsValue = defects.body
          ? _checkNotNull(bodyDefects, DeviceAssessmentStep.bodyDefects)
          : BodyDefects.none;
      panelDefectsValue = defects.panel
          ? _checkNotNull(panelDefects, DeviceAssessmentStep.panelDefects)
          : PanelDefects.none;
    }

    final additionalIssuesValue = _checkNotNull(
      additionalIssues,
      DeviceAssessmentStep.additionalDefects,
    );
    final accessoriesValue = _checkNotNull(
      accessories,
      DeviceAssessmentStep.accessories,
    );
    final warrantyPeriodValue = _checkNotNull(
      warrantyPeriod,
      DeviceAssessmentStep.warranty,
    );
    //    final imagesValue = _checkNotNull(images, DeviceAssessmentStep.imageUpload);

    return DeviceAssessment(
      imei: imei ?? Imei(''),
      functionality: functionalityValue,
      defects: defectsValue,
      screenDefects: screenDefectsValue,
      displayDefects: displayDefectsValue,
      bodyDefects: bodyDefectsValue,
      panelDefects: panelDefectsValue,
      additionalIssues: additionalIssuesValue,
      accessories: accessoriesValue,
      warrantyPeriod: warrantyPeriodValue,
    );
  }

  DeviceAssessmentInput withIgnoreDefects(bool ignore) => DeviceAssessmentInput(
    imei: imei,
    functionality: functionality,
    ignoreDefects: ignore,
    defects: ignore ? DeviceDefectsSelection.none : defects,
    screenDefects: ignore ? null : screenDefects,
    displayDefects: ignore ? null : displayDefects,
    bodyDefects: ignore ? null : bodyDefects,
    panelDefects: ignore ? null : panelDefects,
    additionalIssues: additionalIssues,
    accessories: accessories,
    warrantyPeriod: warrantyPeriod,
    images: images,
  );

  DeviceAssessmentInput copyWith({
    Imei? imei,
    DeviceFunctionalityInput? functionality,
    bool? ignoreDefects,
    DeviceDefectsSelection? defects,
    ScreenDefects? screenDefects,
    DisplayDefects? displayDefects,
    BodyDefects? bodyDefects,
    PanelDefects? panelDefects,
    AdditionalIssues? additionalIssues,
    Accessories? accessories,
    WarrantyPeriod? warrantyPeriod,
    DeviceImages? images,
  }) => DeviceAssessmentInput(
    imei: imei ?? this.imei,
    functionality: functionality ?? this.functionality,
    ignoreDefects: ignoreDefects ?? this.ignoreDefects,
    defects: defects ?? this.defects,
    screenDefects: screenDefects ?? this.screenDefects,
    displayDefects: displayDefects ?? this.displayDefects,
    bodyDefects: bodyDefects ?? this.bodyDefects,
    panelDefects: panelDefects ?? this.panelDefects,
    additionalIssues: additionalIssues ?? this.additionalIssues,
    accessories: accessories ?? this.accessories,
    warrantyPeriod: warrantyPeriod ?? this.warrantyPeriod,
    images: images ?? this.images,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceAssessmentInput &&
          runtimeType == other.runtimeType &&
          imei == other.imei &&
          functionality == other.functionality &&
          ignoreDefects == other.ignoreDefects &&
          defects == other.defects &&
          screenDefects == other.screenDefects &&
          displayDefects == other.displayDefects &&
          bodyDefects == other.bodyDefects &&
          panelDefects == other.panelDefects &&
          additionalIssues == other.additionalIssues &&
          accessories == other.accessories &&
          warrantyPeriod == other.warrantyPeriod &&
          images == other.images;

  @override
  int get hashCode => Object.hash(
    imei,
    functionality,
    ignoreDefects,
    defects,
    screenDefects,
    displayDefects,
    bodyDefects,
    panelDefects,
    additionalIssues,
    accessories,
    warrantyPeriod,
    images,
  );
}

class DeviceFunctionalityInput {
  final bool? canMakeReceiveCalls;
  final bool? touchWorking;
  final bool? screenOriginal;
  final bool? underWarranty;
  final bool? hasGstBill;
  final int? eSimCount;

  const DeviceFunctionalityInput({
    this.canMakeReceiveCalls,
    this.touchWorking,
    this.screenOriginal,
    this.underWarranty,
    this.hasGstBill,
    this.eSimCount,
  });

  static const empty = DeviceFunctionalityInput();

  DeviceFunctionality toFunctionality() => DeviceFunctionality(
    canMakeReceiveCalls: _checkNotNull(
      canMakeReceiveCalls,
      QuestionnaireStore.makeReceiveCalls.text,
    ),
    touchWorking: _checkNotNull(
      touchWorking,
      QuestionnaireStore.touchScreenWorking.text,
    ),
    screenOriginal: _checkNotNull(
      screenOriginal,
      QuestionnaireStore.screenOriginal.text,
    ),
    underWarranty: _checkNotNull(
      underWarranty,
      QuestionnaireStore.deviceUnderWarranty.text,
    ),
    hasGstBill: _checkNotNull(
      hasGstBill,
      QuestionnaireStore.gstBillWithImei.text,
    ),
    numberOfESims: eSimCount ?? 0,
  );

  DeviceFunctionalityInput answered({
    required AssessmentQuestion question,
    required bool answer,
  }) => switch (question) {
    QuestionnaireStore.makeReceiveCalls => copyWith(
      canMakeReceiveCalls: answer,
    ),
    QuestionnaireStore.touchScreenWorking => copyWith(touchWorking: answer),
    QuestionnaireStore.screenOriginal => copyWith(screenOriginal: answer),
    QuestionnaireStore.deviceUnderWarranty => copyWith(underWarranty: answer),
    QuestionnaireStore.gstBillWithImei => copyWith(hasGstBill: answer),
    QuestionnaireStore.numberOfESims1 => copyWith(eSimCount: answer ? 1 : null),
    QuestionnaireStore.numberOfESims2 => copyWith(eSimCount: answer ? 2 : null),
    // QuestionnaireStore.hasOriginalBox => copyWith(hasOriginalBoxWithImei: answer),
    _ => unrecognizedQuestion(question),
  };

  bool? answerForQuestion(AssessmentQuestion question) => switch (question) {
    QuestionnaireStore.makeReceiveCalls => canMakeReceiveCalls,
    QuestionnaireStore.touchScreenWorking => touchWorking,
    QuestionnaireStore.screenOriginal => screenOriginal,
    QuestionnaireStore.deviceUnderWarranty => underWarranty,
    QuestionnaireStore.gstBillWithImei => hasGstBill,
    QuestionnaireStore.numberOfESims1 => eSimCount == 1,
    QuestionnaireStore.numberOfESims2 => eSimCount == 2,
    _ => unrecognizedQuestion(question),
  };

  Never unrecognizedQuestion(
    AssessmentQuestion question,
  ) => throw ArgumentError(
    'The question of id ${question.id} is not recognized as device functionality question.',
  );

  DeviceFunctionalityInput copyWith({
    bool? canMakeReceiveCalls,
    bool? touchWorking,
    bool? screenOriginal,
    bool? underWarranty,
    bool? hasGstBill,
    int? eSimCount,
  }) => DeviceFunctionalityInput(
    canMakeReceiveCalls: canMakeReceiveCalls ?? this.canMakeReceiveCalls,
    touchWorking: touchWorking ?? this.touchWorking,
    screenOriginal: screenOriginal ?? this.screenOriginal,
    underWarranty: underWarranty ?? this.underWarranty,
    hasGstBill: hasGstBill ?? this.hasGstBill,
    eSimCount: eSimCount ?? this.eSimCount,
  );

  static bool _checkNotNull(bool? value, String field) =>
      DeviceAssessmentInputException.checkFieldNotNull(
        value,
        field,
        DeviceAssessmentStep.functionality,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceFunctionalityInput &&
          runtimeType == other.runtimeType &&
          canMakeReceiveCalls == other.canMakeReceiveCalls &&
          touchWorking == other.touchWorking &&
          screenOriginal == other.screenOriginal &&
          underWarranty == other.underWarranty &&
          hasGstBill == other.hasGstBill &&
          eSimCount == other.eSimCount;

  @override
  int get hashCode => Object.hash(
    canMakeReceiveCalls,
    touchWorking,
    screenOriginal,
    underWarranty,
    hasGstBill,
    eSimCount,
  );
}

class DeviceAssessmentInputException implements Exception {
  final String message;
  const DeviceAssessmentInputException(this.message);
  const DeviceAssessmentInputException.missingStep(String step)
    : message = 'Missing required input for step: $step';
  const DeviceAssessmentInputException.missingField(String field, String step)
    : message = 'Missing required field "$field" for step: $step';

  @override
  String toString() => 'DeviceAssessmentInputException: $message';

  static T checkStepNotNull<T>(T? value, DeviceAssessmentStep step) {
    if (value == null) {
      throw DeviceAssessmentInputException.missingStep(step.name);
    }
    return value;
  }

  static T checkFieldNotNull<T>(
    T? value,
    String field,
    DeviceAssessmentStep step,
  ) {
    if (value == null) {
      throw DeviceAssessmentInputException.missingField(field, step.name);
    }
    return value;
  }
}
