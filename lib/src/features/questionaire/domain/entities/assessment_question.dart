class AssessmentQuestion {
  final String id;
  final String text;

  const AssessmentQuestion({
    required this.id,
    required this.text,
  });

  factory AssessmentQuestion.fromJson(Map<String, dynamic> json) =>
      AssessmentQuestion(
        id: json['id'] as String,
        text: json['question'] as String,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': text,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssessmentQuestion &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text;

  @override
  int get hashCode => Object.hash(id, text);
}

class AssessmentQuestionResponse {
  const AssessmentQuestionResponse({
    required this.questionId,
    required this.response,
  });

  factory AssessmentQuestionResponse.fromJson(Map<String, dynamic> json) =>
      AssessmentQuestionResponse(
        questionId: json['questionId'] as String,
        response: json['response'] as String,
      );

  final String questionId;

  final String response;

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