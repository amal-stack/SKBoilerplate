import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/step.dart';
import 'package:boilerplate/src/features/questionaire/domain/repositories/questionnaire_repository.dart';
import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionnaireCubit extends Cubit<ViewState<List<AssessmentQuestion>>> {
  QuestionnaireCubit(this.repository) : super(const ViewState.initial());

  final QuestionnaireRepository repository;

  Future<void> questionsForStep(DeviceAssessmentStep step) async {
    emit(const ViewState.loading());
    try {
      final questions = await repository.questionsForStep(step);
      emit(ViewState.success(questions));
    } catch (e) {
      emit(ViewState.error(e.toString()));
    }
  }
}
