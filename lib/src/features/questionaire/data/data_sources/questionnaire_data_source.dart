
import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';

abstract final class QuestionnaireData {
  /// "1. Are you able to make and receive calls?",
  ///  "2. Is the touch screen working?",
  ///  "3. Is your phone's screen original?",
  ///  "4. Is the device under warranty?",
  ///  "5. Do you have a GST bill with the same IMEI?",
  ///  "6. How many eSIMs are supported?",
  static const List<AssessmentQuestion> questions = [
    AssessmentQuestion(id: 'Q1', text: "1. Are you able to make and receive calls?"),
    AssessmentQuestion(id: 'Q2', text: "2. Is the touch screen working?"),
    AssessmentQuestion(id: 'Q3', text: "3. Is your phone's screen original?"),
    AssessmentQuestion(id: 'Q4', text: "4. Is the device under warranty?"),
    AssessmentQuestion(id: 'Q5', text: "5. Do you have a GST bill with the same IMEI?"),
    AssessmentQuestion(id: 'Q6', text: "6. How many eSIMs are supported?"),
  ];
}

abstract interface class QuestionnaireDataSource {
  Future<ListDataResponse<AssessmentQuestion>> questions();
}