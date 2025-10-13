import 'package:boilerplate/src/features/questionaire/data/data_sources/local/mapper.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';

class AssessmentQuestionResponse {
  const AssessmentQuestionResponse({
    required this.questionId,
    required this.response,
  });

  AssessmentQuestionResponse.fromJson(Map<String, dynamic> json)
    : questionId = json['questionId'] as String,
      response = json['response'] as bool;

  final String questionId;

  final bool response;

  Map<String, dynamic> toJson() => {
    'questionId': questionId,
    'response': response,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssessmentQuestionResponse &&
          runtimeType == other.runtimeType &&
          questionId == other.questionId &&
          response == other.response;

  @override
  int get hashCode => Object.hash(questionId, response);
}

class AssessmentResponse {
  const AssessmentResponse({required this.questions});

  AssessmentResponse.fromJson(Map<String, dynamic> json)
    : questions = [
        for (var item in (json['questions'] as List<dynamic>))
          AssessmentQuestionResponse.fromJson(item as Map<String, dynamic>),
      ];

  AssessmentResponse.fromAssessment(DeviceAssessment assessment)
    : questions = DomainToAssessmentResponseMapper.assessment(assessment);

  final List<AssessmentQuestionResponse> questions;

  Map<String, dynamic> toJson() => {
    'responses': [for (var q in questions) q.toJson()],
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssessmentResponse &&
          runtimeType == other.runtimeType &&
          questions == other.questions;

  @override
  int get hashCode => questions.hashCode;
}
