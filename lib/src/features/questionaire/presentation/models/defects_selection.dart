import 'package:boilerplate/src/features/questionaire/presentation/models/step.dart';

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
