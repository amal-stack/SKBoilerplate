import 'package:boilerplate/src/features/questionaire/data/data_sources/questionnaire_data_source.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';
import 'package:boilerplate/src/features/questionaire/domain/repositories/questionnaire_repository.dart';

class RemoteQuestionnaireRepository implements QuestionnaireRepository {
  const RemoteQuestionnaireRepository(this.dataSource);

  final QuestionnaireDataSource dataSource;

  @override
  Future<List<AssessmentQuestion>> questions() =>
      dataSource.questions().then((response) => response.data!);
}
