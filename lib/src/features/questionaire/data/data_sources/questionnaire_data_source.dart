import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';

abstract interface class QuestionnaireDataSource {
  Future<ListDataResponse<AssessmentQuestion>> allQuestions();

  Future<ListDataResponse<AssessmentQuestion>> deviceFunctionalityQuestions();

  Future<ListDataResponse<AssessmentQuestion>> defectsSelectionQuestions();

  Future<ListDataResponse<AssessmentQuestion>> screenDefectsQuestions();

  Future<ListDataResponse<AssessmentQuestion>> displayDefectsQuestions();

  Future<ListDataResponse<AssessmentQuestion>> bodyDefectsQuestions();

  Future<ListDataResponse<AssessmentQuestion>> panelDefectsQuestions();

  Future<ListDataResponse<AssessmentQuestion>> additionalIssuesQuestions();

  Future<ListDataResponse<AssessmentQuestion>> accessoriesQuestions();

  Future<ListDataResponse<AssessmentQuestion>> warrantyQuestions();
}
