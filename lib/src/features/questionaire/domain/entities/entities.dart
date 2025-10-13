import 'package:meta/meta.dart';

extension type const Imei(String value) {}

@immutable
class DeviceFunctionality {
  final bool canMakeReceiveCalls;
  final bool touchWorking;
  final bool screenOriginal;
  final bool underWarranty;
  final bool hasGstBill;
  final bool esimSupported;

  const DeviceFunctionality({
    required this.canMakeReceiveCalls,
    required this.touchWorking,
    required this.screenOriginal,
    required this.underWarranty,
    required this.hasGstBill,
    required this.esimSupported,
  });

  static const functional = DeviceFunctionality(
    canMakeReceiveCalls: true,
    touchWorking: true,
    screenOriginal: true,
    underWarranty: true,
    hasGstBill: true,
    esimSupported: true,
  );

  DeviceFunctionality.fromJson(Map<String, dynamic> json)
    : canMakeReceiveCalls = json['canMakeReceiveCalls'],
      touchWorking = json['touchWorking'],
      screenOriginal = json['screenOriginal'],
      underWarranty = json['underWarranty'],
      hasGstBill = json['hasGstBill'],
      esimSupported = json['esimSupported'];

  Map<String, dynamic> toJson() => {
    'canMakeReceiveCalls': canMakeReceiveCalls,
    'touchWorking': touchWorking,
    'screenOriginal': screenOriginal,
    'underWarranty': underWarranty,
    'hasGstBill': hasGstBill,
    'esimSupported': esimSupported,
  };

  DeviceFunctionality copyWith({
    bool? canMakeReceiveCalls,
    bool? touchWorking,
    bool? screenOriginal,
    bool? underWarranty,
    bool? hasGstBill,
    bool? esimSupported,
  }) => DeviceFunctionality(
    canMakeReceiveCalls: canMakeReceiveCalls ?? this.canMakeReceiveCalls,
    touchWorking: touchWorking ?? this.touchWorking,
    screenOriginal: screenOriginal ?? this.screenOriginal,
    underWarranty: underWarranty ?? this.underWarranty,
    hasGstBill: hasGstBill ?? this.hasGstBill,
    esimSupported: esimSupported ?? this.esimSupported,
  );

  @override
  bool operator ==(Object other) =>
      other is DeviceFunctionality &&
      other.canMakeReceiveCalls == canMakeReceiveCalls &&
      other.touchWorking == touchWorking &&
      other.screenOriginal == screenOriginal &&
      other.underWarranty == underWarranty &&
      other.hasGstBill == hasGstBill &&
      other.esimSupported == esimSupported;

  @override
  int get hashCode => Object.hash(
    canMakeReceiveCalls,
    touchWorking,
    screenOriginal,
    underWarranty,
    hasGstBill,
    esimSupported,
  );
}

class DeviceDefectsSelection {
  const DeviceDefectsSelection({
    required this.screen,
    required this.display,
    required this.body,
    required this.panel,
  });

  DeviceDefectsSelection.fromJson(Map<String, dynamic> json)
    : screen = json['screen'],
      display = json['display'],
      body = json['body'],
      panel = json['panel'];

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

  Map<String, dynamic> toJson() => {
    'screen': screen,
    'display': display,
    'body': body,
    'panel': panel,
  };

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
}

@immutable
class ScreenDefects {
  final bool crackedGlass;
  final bool cracksOutsideDisplay;
  final bool multipleScratches;
  final bool minorScratches;

  const ScreenDefects({
    required this.crackedGlass,
    required this.cracksOutsideDisplay,
    required this.multipleScratches,
    required this.minorScratches,
  });

  ScreenDefects.fromJson(Map<String, dynamic> json)
    : crackedGlass = json['crackedGlass'],
      cracksOutsideDisplay = json['cracksOutsideDisplay'],
      multipleScratches = json['multipleScratches'],
      minorScratches = json['minorScratches'];

  static const none = ScreenDefects(
    crackedGlass: false,
    cracksOutsideDisplay: false,
    multipleScratches: false,
    minorScratches: false,
  );

  Map<String, dynamic> toJson() => {
    'crackedGlass': crackedGlass,
    'cracksOutsideDisplay': cracksOutsideDisplay,
    'multipleScratches': multipleScratches,
    'minorScratches': minorScratches,
  };

  ScreenDefects copyWith({
    bool? crackedGlass,
    bool? cracksOutsideDisplay,
    bool? multipleScratches,
    bool? minorScratches,
  }) => ScreenDefects(
    crackedGlass: crackedGlass ?? this.crackedGlass,
    cracksOutsideDisplay: cracksOutsideDisplay ?? this.cracksOutsideDisplay,
    multipleScratches: multipleScratches ?? this.multipleScratches,
    minorScratches: minorScratches ?? this.minorScratches,
  );

  @override
  bool operator ==(Object other) =>
      other is ScreenDefects &&
      other.crackedGlass == crackedGlass &&
      other.cracksOutsideDisplay == cracksOutsideDisplay &&
      other.multipleScratches == multipleScratches &&
      other.minorScratches == minorScratches;

  @override
  int get hashCode => Object.hash(
    crackedGlass,
    cracksOutsideDisplay,
    multipleScratches,
    minorScratches,
  );
}

@immutable
class DisplayDefects {
  final DisplaySpots spots;
  final DisplayLines lines;
  final Discoloration discoloration;

  const DisplayDefects({
    required this.spots,
    required this.lines,
    required this.discoloration,
  });

  static const none = DisplayDefects(
    spots: DisplaySpots.none,
    lines: DisplayLines.none,
    discoloration: Discoloration.none,
  );

  DisplayDefects.fromJson(Map<String, dynamic> json)
    : spots = DisplaySpots.values.byName(json['spots']),
      lines = DisplayLines.values.byName(json['lines']),
      discoloration = Discoloration.values.byName(json['discoloration']);

  Map<String, dynamic> toJson() => {
    'spots': spots.name,
    'lines': lines.name,
    'discoloration': discoloration.name,
  };

  DisplayDefects copyWith({
    DisplaySpots? spots,
    DisplayLines? lines,
    Discoloration? discoloration,
  }) => DisplayDefects(
    spots: spots ?? this.spots,
    lines: lines ?? this.lines,
    discoloration: discoloration ?? this.discoloration,
  );

  @override
  bool operator ==(Object other) =>
      other is DisplayDefects &&
      other.spots == spots &&
      other.lines == lines &&
      other.discoloration == discoloration;

  @override
  int get hashCode => Object.hash(spots, lines, discoloration);
}

enum DisplaySpots {
  largeHeavy,
  threeOrMoreSmall,
  oneOrTwoSmall,
  none;
}

enum DisplayLines {
  hasVisible,
  fadedEdges,
  none;

}

enum Discoloration {
  severe,
  minor,
  none;
}

@immutable
class BodyDefects {
  final ScratchSeverity scratches;
  final DentSeverity dents;

  const BodyDefects({required this.scratches, required this.dents});

  static const none = BodyDefects(
    scratches: ScratchSeverity.none,
    dents: DentSeverity.none,
  );

  BodyDefects.fromJson(Map<String, dynamic> json)
    : scratches = ScratchSeverity.values.byName(json['scratches']),
      dents = DentSeverity.values.byName(json['dents']);

  Map<String, dynamic> toJson() => {
    'scratches': scratches.name,
    'dents': dents.name,
  };

  BodyDefects copyWith({ScratchSeverity? scratches, DentSeverity? dents}) =>
      BodyDefects(
        scratches: scratches ?? this.scratches,
        dents: dents ?? this.dents,
      );

  @override
  bool operator ==(Object other) =>
      other is BodyDefects &&
      other.scratches == scratches &&
      other.dents == dents;

  @override
  int get hashCode => Object.hash(scratches, dents);
}

enum ScratchSeverity {
  moreThanTwo,
  oneOrTwo,
  none;
}

enum DentSeverity {
  multiple,
  oneOrTwoMinor,
  none;
}

@immutable
class PanelDefects {
  final PanelDamage panelDamage;
  final FrameCondition frameCondition;

  const PanelDefects({required this.panelDamage, required this.frameCondition});

  static const none = PanelDefects(
    panelDamage: PanelDamage.none,
    frameCondition: FrameCondition.straight,
  );

  PanelDefects.fromJson(Map<String, dynamic> json)
    : panelDamage = PanelDamage.values.byName(json['panelDamage']),
      frameCondition = FrameCondition.values.byName(json['frameCondition']);

  Map<String, dynamic> toJson() => {
    'panelDamage': panelDamage.name,
    'frameCondition': frameCondition.name,
  };

  PanelDefects copyWith({
    PanelDamage? panelDamage,
    FrameCondition? frameCondition,
  }) => PanelDefects(
    panelDamage: panelDamage ?? this.panelDamage,
    frameCondition: frameCondition ?? this.frameCondition,
  );

  @override
  bool operator ==(Object other) =>
      other is PanelDefects &&
      other.panelDamage == panelDamage &&
      other.frameCondition == frameCondition;

  @override
  int get hashCode => Object.hash(panelDamage, frameCondition);
}

enum PanelDamage {
  cracked,
  missing,
  none;

  bool get hasDamage => this != PanelDamage.none;
}

enum FrameCondition {
  bent,
  loose,
  straight;

  bool get isDefective => this != FrameCondition.straight;
}

@immutable
class AdditionalIssues {
  final Set<AdditionalIssue> issues;

  final BatteryHealth batteryHealth;

  const AdditionalIssues(this.issues, {required this.batteryHealth});

  static const none = AdditionalIssues(
    {},
    batteryHealth: BatteryHealth.healthy,
  );

  AdditionalIssues.fromJson(Map<String, dynamic> json)
    : issues = (json['issues'] as List)
          .map((e) => AdditionalIssue.values.byName(e))
          .toSet(),
      batteryHealth = BatteryHealth.values.byName(json['batteryHealth']);

  bool hasIssue(AdditionalIssue issue) => issues.contains(issue);

  Map<String, dynamic> toJson() => {
    'issues': issues.map((e) => e.name).toList(),
    'batteryHealth': batteryHealth.name,
  };

  AdditionalIssues withIssueToggled(AdditionalIssue issue) => hasIssue(issue)
      ? copyWith(issues: Set.of(issues)..remove(issue))
      : copyWith(issues: {...issues, issue});

  AdditionalIssues copyWith({
    Set<AdditionalIssue>? issues,
    BatteryHealth? batteryHealth,
  }) => AdditionalIssues(
    issues ?? this.issues,
    batteryHealth: batteryHealth ?? this.batteryHealth,
  );

  @override
  bool operator ==(Object other) =>
      other is AdditionalIssues &&
      other.issues.length == issues.length &&
      other.issues.containsAll(issues) &&
      other.batteryHealth == batteryHealth;

  @override
  int get hashCode => Object.hash(Object.hashAll(issues), batteryHealth);
}

enum AdditionalIssue {
  frontCamera,
  rearCamera,
  volumeButtons,
  fingerprintSensor,
  wifi,
  speaker,
  silentSwitch,
  faceRecognition,
  powerButton,
  chargingPort,
  audioReceiver,
  cameraGlass,
  microphone,
  bluetooth,
  vibrationMotor,
  proximitySensor,
}

enum BatteryHealth { below80, from80to85, healthy }

@immutable
class Accessories {
  final bool originalCharger;
  final bool originalBox;

  const Accessories({required this.originalCharger, required this.originalBox});

  static const none = Accessories(originalCharger: false, originalBox: false);

  Accessories.fromJson(Map<String, dynamic> json)
    : originalCharger = json['originalCharger'],
      originalBox = json['originalBox'];

  Map<String, dynamic> toJson() => {
    'originalCharger': originalCharger,
    'originalBox': originalBox,
  };

  Accessories copyWith({bool? originalCharger, bool? originalBox}) =>
      Accessories(
        originalCharger: originalCharger ?? this.originalCharger,
        originalBox: originalBox ?? this.originalBox,
      );

  @override
  bool operator ==(Object other) =>
      other is Accessories &&
      other.originalCharger == originalCharger &&
      other.originalBox == originalBox;

  @override
  int get hashCode => Object.hash(originalCharger, originalBox);
}

enum WarrantyPeriod {
  below3Months,
  from3to6,
  from6to11,
  above11,
  outOfWarranty;

  bool get isInWarranty => this != WarrantyPeriod.outOfWarranty;
}

@immutable
class DeviceImages {
  final String front;
  final String back;
  final String left;
  final String right;
  final String top;
  final String bottom;

  const DeviceImages({
    required this.front,
    required this.back,
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
  });

  DeviceImages.fromJson(Map<String, dynamic> json)
    : front = json['front'],
      back = json['back'],
      left = json['left'],
      right = json['right'],
      top = json['top'],
      bottom = json['bottom'];

  Map<String, dynamic> toJson() => {
    'front': front,
    'back': back,
    'left': left,
    'right': right,
    'top': top,
    'bottom': bottom,
  };

  DeviceImages copyWith({
    String? front,
    String? back,
    String? left,
    String? right,
    String? top,
    String? bottom,
  }) => DeviceImages(
    front: front ?? this.front,
    back: back ?? this.back,
    left: left ?? this.left,
    right: right ?? this.right,
    top: top ?? this.top,
    bottom: bottom ?? this.bottom,
  );

  @override
  bool operator ==(Object other) =>
      other is DeviceImages &&
      other.front == front &&
      other.back == back &&
      other.left == left &&
      other.right == right &&
      other.top == top &&
      other.bottom == bottom;

  @override
  int get hashCode => Object.hash(front, back, left, right, top, bottom);
}

class DeviceInvoice {
  final String path;

  const DeviceInvoice({required this.path});

  DeviceInvoice.fromJson(Map<String, dynamic> json) : path = json['path'];

  Map<String, dynamic> toJson() => {'path': path};

  DeviceInvoice copyWith({String? path}) =>
      DeviceInvoice(path: path ?? this.path);

  @override
  bool operator ==(Object other) =>
      other is DeviceInvoice && other.path == path;

  @override
  int get hashCode => path.hashCode;
}

@immutable
class DeviceAssessment {
  final Imei imei;
  final DeviceFunctionality functionality;
  final DeviceDefectsSelection defects;
  final ScreenDefects screenDefects;
  final DisplayDefects displayDefects;
  final BodyDefects bodyDefects;
  final PanelDefects panelDefects;
  final AdditionalIssues additionalIssues;
  final Accessories accessories;
  final WarrantyPeriod warrantyPeriod;

  const DeviceAssessment({
    required this.imei,
    required this.functionality,
    required this.defects,
    required this.screenDefects,
    required this.displayDefects,
    required this.bodyDefects,
    required this.panelDefects,
    required this.additionalIssues,
    required this.accessories,
    required this.warrantyPeriod,
  });

  const DeviceAssessment.defectless({
    required this.imei,
    required this.functionality,
    required this.accessories,
    required this.warrantyPeriod,
  }) : defects = DeviceDefectsSelection.none,
       screenDefects = ScreenDefects.none,
       displayDefects = DisplayDefects.none,
       bodyDefects = BodyDefects.none,
       panelDefects = PanelDefects.none,
       additionalIssues = AdditionalIssues.none;

  DeviceAssessment.fromJson(Map<String, dynamic> json)
    : imei = Imei(json['imei']),
      functionality = DeviceFunctionality.fromJson(json['functionality']),
      defects = DeviceDefectsSelection.fromJson(json['defects']),
      screenDefects = ScreenDefects.fromJson(json['screenDefects']),
      displayDefects = DisplayDefects.fromJson(json['displayDefects']),
      bodyDefects = BodyDefects.fromJson(json['bodyDefects']),
      panelDefects = PanelDefects.fromJson(json['panelDefects']),
      additionalIssues = AdditionalIssues.fromJson(json['additionalIssues']),
      accessories = Accessories.fromJson(json['accessories']),
      warrantyPeriod = WarrantyPeriod.values.byName(json['warrantyPeriod']);

  Map<String, dynamic> toJson() => {
    'imei': imei,
    'functionality': functionality.toJson(),
    'screenDefects': screenDefects.toJson(),
    'displayDefects': displayDefects.toJson(),
    'bodyDefects': bodyDefects.toJson(),
    'panelDefects': panelDefects.toJson(),
    'additionalIssues': additionalIssues.toJson(),
    'accessories': accessories.toJson(),
    'warrantyPeriod': warrantyPeriod.name,
  };

  DeviceAssessment copyWith({
    Imei? imei,
    DeviceFunctionality? functionality,
    DeviceDefectsSelection? defects,
    bool? hasNoDefects,
    ScreenDefects? screenDefects,
    DisplayDefects? displayDefects,
    BodyDefects? bodyDefects,
    PanelDefects? panelDefects,
    AdditionalIssues? additionalIssues,
    Accessories? accessories,
    WarrantyPeriod? warrantyPeriod,
  }) => DeviceAssessment(
    imei: imei ?? this.imei,
    functionality: functionality ?? this.functionality,
    defects: defects ?? this.defects,

    screenDefects: screenDefects ?? this.screenDefects,
    displayDefects: displayDefects ?? this.displayDefects,
    bodyDefects: bodyDefects ?? this.bodyDefects,
    panelDefects: panelDefects ?? this.panelDefects,
    additionalIssues: additionalIssues ?? this.additionalIssues,
    accessories: accessories ?? this.accessories,
    warrantyPeriod: warrantyPeriod ?? this.warrantyPeriod,
  );

  @override
  bool operator ==(Object other) =>
      other is DeviceAssessment &&
      other.imei == imei &&
      other.functionality == functionality &&
      other.screenDefects == screenDefects &&
      other.displayDefects == displayDefects &&
      other.bodyDefects == bodyDefects &&
      other.panelDefects == panelDefects &&
      other.additionalIssues == additionalIssues &&
      other.accessories == accessories &&
      other.warrantyPeriod == warrantyPeriod;

  @override
  int get hashCode => Object.hash(
    imei,
    functionality,

    screenDefects,
    displayDefects,
    bodyDefects,
    panelDefects,
    additionalIssues,
    accessories,
    warrantyPeriod,
  );
}
