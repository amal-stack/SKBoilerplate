import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/step.dart';
import 'package:boilerplate/src/features/questionaire/domain/repositories/grades_repository.dart';
import 'package:boilerplate/src/features/questionaire/presentation/models/flow_state.dart';
import 'package:boilerplate/src/features/questionaire/presentation/models/input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceAssessmentCubit extends Cubit<DeviceAssessmentState> {
  DeviceAssessmentCubit(this._repository)
    : super(DeviceAssessmentState.initial(DeviceAssessmentFlowState.initial));

  final GradesRepository _repository;

  DeviceAssessmentInput get input => state.flow.input;

  DeviceAssessmentStep get step => state.flow.currentStep;

  void functionalityChanged(DeviceFunctionalityInput functionality) {
    emit(state.withInput(input.copyWith(functionality: functionality)));
  }

  void answerFunctionalityQuestion({
    required AssessmentQuestion question,
    required bool answer,
  }) {
    final currentFunctionality =
        input.functionality ?? DeviceFunctionalityInput();
    emit(
      state.withInput(
        input.copyWith(
          functionality: currentFunctionality.answered(
            question: question,
            answer: answer,
          ),
        ),
      ),
    );
  }

  void ignoreDefectsChanged([bool? ignore]) {
    final newIgnore = ignore ?? !input.ignoreDefects;
    emit(state.withInput(input.withIgnoreDefects(newIgnore)));
  }

  void defectsSelectionChanged(DeviceDefectsSelection defects) {
    if (input.ignoreDefects) {
      return;
    }
    emit(state.withInput(input.copyWith(defects: defects)));
  }

  void screenDefectsChanged(ScreenDefects defects) {
    emit(state.withInput(input.copyWith(screenDefects: defects)));
  }

  void displayDefectsChanged(DisplayDefects defects) {
    emit(state.withInput(input.copyWith(displayDefects: defects)));
  }

  void bodyDefectsChanged(BodyDefects defects) {
    emit(state.withInput(input.copyWith(bodyDefects: defects)));
  }

  void panelDefectsChanged(PanelDefects defects) {
    emit(state.withInput(input.copyWith(panelDefects: defects)));
  }

  void additionalIssuesChanged(AdditionalIssues issues) {
    emit(state.withInput(input.copyWith(additionalIssues: issues)));
  }

  void accessoriesChanged(Accessories accessories) {
    emit(state.withInput(input.copyWith(accessories: accessories)));
  }

  void warrantyPeriodChanged(WarrantyPeriod period) {
    emit(state.withInput(input.copyWith(warrantyPeriod: period)));
  }

  void nextStep() {
    emit(state.withNextStep());
  }

  void previousStep() {
    emit(state.withPreviousStep());
  }

  Future<void> calculateGrade({required String quoteId}) async {
    emit(DeviceAssessmentState.submitting(state.flow));
    try {
      final assessment = input.toAssessment();
      final result = await _repository.grade(
        quoteId: quoteId,
        assessment: assessment,
      );
      emit(DeviceAssessmentState.completed(state.flow, result: result));
    } catch (e) {
      emit(DeviceAssessmentState.error(state.flow, message: e.toString()));
    }
  }
}
