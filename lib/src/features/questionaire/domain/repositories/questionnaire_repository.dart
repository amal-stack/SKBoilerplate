
import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';

abstract interface class QuestionnaireRepository {
  Future<List<AssessmentQuestion>> questions();
}