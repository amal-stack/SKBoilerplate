import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/presentation/models/defects_selection.dart';

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
