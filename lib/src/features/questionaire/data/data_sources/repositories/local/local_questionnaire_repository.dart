import 'package:boilerplate/src/features/questionaire/data/data_sources/questionnaire_data_source.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';
import 'package:boilerplate/src/features/questionaire/domain/repositories/questionnaire_repository.dart';

class LocalQuestionnaireRepository implements QuestionnaireRepository {
  const LocalQuestionnaireRepository(this.dataSource);

  final QuestionnaireDataSource dataSource;

  @override
  Future<List<AssessmentQuestion>> additionalIssuesQuestions() => dataSource
      .additionalIssuesQuestions()
      .then((response) => response.requireData);

  @override
  Future<List<AssessmentQuestion>> allQuestions() =>
      dataSource.allQuestions().then((response) => response.requireData);

  @override
  Future<List<AssessmentQuestion>> bodyDefectsQuestions() => dataSource
      .bodyDefectsQuestions()
      .then((response) => response.requireData);

  @override
  Future<List<AssessmentQuestion>> defectsSelectionQuestions() => dataSource
      .defectsSelectionQuestions()
      .then((response) => response.requireData);

  @override
  Future<List<AssessmentQuestion>> deviceFunctionalityQuestions() => dataSource
      .deviceFunctionalityQuestions()
      .then((response) => response.requireData);

  @override
  Future<List<AssessmentQuestion>> displayDefectsQuestions() => dataSource
      .displayDefectsQuestions()
      .then((response) => response.requireData);

  @override
  Future<List<AssessmentQuestion>> panelDefectsQuestions() => dataSource
      .panelDefectsQuestions()
      .then((response) => response.requireData);

  @override
  Future<List<AssessmentQuestion>> screenDefectsQuestions() => dataSource
      .screenDefectsQuestions()
      .then((response) => response.requireData);


  @override
  Future<List<AssessmentQuestion>> accessoriesQuestions() => dataSource
      .accessoriesQuestions()
      .then((response) => response.requireData);

  @override
  Future<List<AssessmentQuestion>> warrantyQuestions() => dataSource
      .warrantyQuestions()
      .then((response) => response.requireData);
}
