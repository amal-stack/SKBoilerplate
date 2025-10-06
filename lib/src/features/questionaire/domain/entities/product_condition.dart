import 'package:meta/meta.dart' show immutable;

@immutable
class ProductCondition {
  const ProductCondition({
    required this.canMakeReceiveCalls,
    required this.hasTouchIssues,
    required this.isDisplayOriginal,
    required this.isUnderWarranty,
    required this.hasGstBill,
    required this.eSimSupported,
  });

  final bool canMakeReceiveCalls;

  final bool hasTouchIssues;

  final bool isDisplayOriginal;

  final bool isUnderWarranty;

  final bool hasGstBill;

  final int eSimSupported;

  Map<String, dynamic> toJson() => {
    'canMakeReceiveCalls': canMakeReceiveCalls,
    'hasTouchIssues': hasTouchIssues,
    'isDisplayOriginal': isDisplayOriginal,
    'isUnderWarranty': isUnderWarranty,
    'hasGstBill': hasGstBill,
    'eSimSupported': eSimSupported,
  };

  ProductCondition copyWith({
    bool? canMakeReceiveCalls,
    bool? hasTouchIssues,
    bool? isDisplayOriginal,
    bool? isUnderWarranty,
    bool? hasGstBill,
    int? eSimSupported,
  }) => ProductCondition(
    canMakeReceiveCalls: canMakeReceiveCalls ?? this.canMakeReceiveCalls,
    hasTouchIssues: hasTouchIssues ?? this.hasTouchIssues,
    isDisplayOriginal: isDisplayOriginal ?? this.isDisplayOriginal,
    isUnderWarranty: isUnderWarranty ?? this.isUnderWarranty,
    hasGstBill: hasGstBill ?? this.hasGstBill,
    eSimSupported: eSimSupported ?? this.eSimSupported,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCondition &&
          runtimeType == other.runtimeType &&
          canMakeReceiveCalls == other.canMakeReceiveCalls &&
          hasTouchIssues == other.hasTouchIssues &&
          isDisplayOriginal == other.isDisplayOriginal &&
          isUnderWarranty == other.isUnderWarranty &&
          hasGstBill == other.hasGstBill &&
          eSimSupported == other.eSimSupported;

  @override
  int get hashCode => Object.hash(
    canMakeReceiveCalls,
    hasTouchIssues,
    isDisplayOriginal,
    isUnderWarranty,
    hasGstBill,
    eSimSupported,
  );
}

@immutable
class DeviceDefects {
  const DeviceDefects({
    required this.hasCracksOrScratchesOnScreen,
    required this.hasDisplayDefects,
    required this.hasCracksOrScratchesOnBody,
    required this.isDevicePanelBrokenOrMissing,
  });

  static const none = DeviceDefects(
    hasCracksOrScratchesOnScreen: false,
    hasDisplayDefects: false,
    hasCracksOrScratchesOnBody: false,
    isDevicePanelBrokenOrMissing: false,
  );

  final bool hasCracksOrScratchesOnScreen;

  final bool hasDisplayDefects;

  final bool hasCracksOrScratchesOnBody;

  final bool isDevicePanelBrokenOrMissing;

  Map<String, dynamic> toJson() => {
    'hasCracksOrScratchesOnScreen': hasCracksOrScratchesOnScreen,
    'hasDisplayDefects': hasDisplayDefects,
    'hasCracksOrScratchesOnBody': hasCracksOrScratchesOnBody,
    'isDevicePanelBrokenOrMissing': isDevicePanelBrokenOrMissing,
  };

  DeviceDefects copyWith({
    bool? hasCracksOrScratchesOnScreen,
    bool? hasDisplayDefects,
    bool? hasCracksOrScratchesOnBody,
    bool? isDevicePanelBrokenOrMissing,
  }) => DeviceDefects(
    hasCracksOrScratchesOnScreen:
        hasCracksOrScratchesOnScreen ?? this.hasCracksOrScratchesOnScreen,
    hasDisplayDefects: hasDisplayDefects ?? this.hasDisplayDefects,
    hasCracksOrScratchesOnBody:
        hasCracksOrScratchesOnBody ?? this.hasCracksOrScratchesOnBody,
    isDevicePanelBrokenOrMissing:
        isDevicePanelBrokenOrMissing ?? this.isDevicePanelBrokenOrMissing,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceDefects &&
          runtimeType == other.runtimeType &&
          hasCracksOrScratchesOnScreen == other.hasCracksOrScratchesOnScreen &&
          hasDisplayDefects == other.hasDisplayDefects &&
          hasCracksOrScratchesOnBody == other.hasCracksOrScratchesOnBody &&
          isDevicePanelBrokenOrMissing == other.isDevicePanelBrokenOrMissing;

  @override
  int get hashCode => Object.hash(
    hasCracksOrScratchesOnScreen,
    hasDisplayDefects,
    hasCracksOrScratchesOnBody,
    isDevicePanelBrokenOrMissing,
  );
}

class SurfaceCondition {
  const SurfaceCondition({
    required this.isScreenCrackedOrBroken,
    required this.hasCracksOutsideDisplayArea,
    required this.hasMultipleScratches,
    required this.hasMinorScratches,
  });

  final bool isScreenCrackedOrBroken;

  final bool hasCracksOutsideDisplayArea;

  final bool hasMultipleScratches;

  final bool hasMinorScratches;

  Map<String, dynamic> toJson() => {
    'isScreenCrackedOrBroken': isScreenCrackedOrBroken,
    'hasCracksOutsideDisplayArea': hasCracksOutsideDisplayArea,
    'hasMultipleScratches': hasMultipleScratches,
    'hasMinorScratches': hasMinorScratches,
  };

  SurfaceCondition copyWith({
    bool? isScreenCrackedOrBroken,
    bool? hasCracksOutsideDisplayArea,
    bool? hasMultipleScratches,
    bool? hasMinorScratches,
  }) => SurfaceCondition(
    isScreenCrackedOrBroken:
        isScreenCrackedOrBroken ?? this.isScreenCrackedOrBroken,
    hasCracksOutsideDisplayArea:
        hasCracksOutsideDisplayArea ?? this.hasCracksOutsideDisplayArea,
    hasMultipleScratches: hasMultipleScratches ?? this.hasMultipleScratches,
    hasMinorScratches: hasMinorScratches ?? this.hasMinorScratches,
  );

  @override
  int get hashCode => Object.hash(
    isScreenCrackedOrBroken,
    hasCracksOutsideDisplayArea,
    hasMultipleScratches,
    hasMinorScratches,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurfaceCondition &&
          runtimeType == other.runtimeType &&
          isScreenCrackedOrBroken == other.isScreenCrackedOrBroken &&
          hasCracksOutsideDisplayArea == other.hasCracksOutsideDisplayArea &&
          hasMultipleScratches == other.hasMultipleScratches &&
          hasMinorScratches == other.hasMinorScratches;
}


class DisplayDefects {
  const DisplayDefects({
    required this.deadPixelsInfo,
    required this.displayLines,
    required this.screenDiscoloration,
  });

  final DeadPixelsInfo deadPixelsInfo;

  final DisplayLines displayLines;

  final ScreenDiscoloration screenDiscoloration;

  Map<String, dynamic> toJson() => {
    'deadPixelsInfo': deadPixelsInfo.index,
    'displayLines': displayLines.index,
    'screenDiscoloration': screenDiscoloration.index,
  };

  DisplayDefects copyWith({
    DeadPixelsInfo? deadPixelsInfo,
    DisplayLines? displayLines,
    ScreenDiscoloration? screenDiscoloration,
  }) => DisplayDefects(
    deadPixelsInfo: deadPixelsInfo ?? this.deadPixelsInfo,
    displayLines: displayLines ?? this.displayLines,
    screenDiscoloration: screenDiscoloration ?? this.screenDiscoloration,
  );
}

enum DeadPixelsInfo {
  none,
  fewSmall,
  manySmall,
  largeOrHeavy,
}

enum DisplayLines {
  none,
  fadedEdges,
  visibleLines,
}

enum ScreenDiscoloration {
  none,
  minor,
  severe,
}

