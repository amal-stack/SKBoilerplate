import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/features/questionaire/data/data_sources/local/questionnaire_store.dart';

import 'package:boilerplate/src/features/questionaire/data/data_sources/questionnaire_data_source.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';
import 'package:meta/meta.dart';

class LocalQuestionnaireDataSource implements QuestionnaireDataSource {
  const LocalQuestionnaireDataSource();

  @override
  Future<ListDataResponse<AssessmentQuestion>> allQuestions() =>
      Future.value(_createResponse(QuestionnaireStore.allQuestions));

  @override
  Future<ListDataResponse<AssessmentQuestion>> additionalIssuesQuestions() =>
      Future.value(
        _createResponse(QuestionnaireStore.additionalIssuesQuestions),
      );

  @override
  Future<ListDataResponse<AssessmentQuestion>> bodyDefectsQuestions() =>
      Future.value(_createResponse(QuestionnaireStore.bodyDefectsQuestions));

  @override
  Future<ListDataResponse<AssessmentQuestion>> defectsSelectionQuestions() =>
      Future.value(
        _createResponse(QuestionnaireStore.defectsSelectionQuestions),
      );

  @override
  Future<ListDataResponse<AssessmentQuestion>> deviceFunctionalityQuestions() =>
      Future.value(_createResponse(QuestionnaireStore.functionalityQuestions));

  @override
  Future<ListDataResponse<AssessmentQuestion>> displayDefectsQuestions() =>
      Future.value(_createResponse(QuestionnaireStore.displayDefectsQuestions));

  @override
  Future<ListDataResponse<AssessmentQuestion>> panelDefectsQuestions() =>
      Future.value(_createResponse(QuestionnaireStore.panelDefectsQuestions));

  @override
  Future<ListDataResponse<AssessmentQuestion>> screenDefectsQuestions() =>
      Future.value(_createResponse(QuestionnaireStore.screenDefectsQuestions));

  @override
  Future<ListDataResponse<AssessmentQuestion>> accessoriesQuestions() =>
      Future.value(_createResponse(QuestionnaireStore.accessoriesQuestions));

  @override
  Future<ListDataResponse<AssessmentQuestion>> warrantyQuestions() =>
      Future.value(_createResponse(QuestionnaireStore.warrantyQuestions));

  @factory
  ListDataResponse<AssessmentQuestion> _createResponse(
    List<AssessmentQuestion> questions,
  ) => ListDataResponse.withConverter(
    success: true,
    message: 'Local questions fetched successfully',
    data: questions,
    itemToJson: (data) => data.toJson(),
  );
}
