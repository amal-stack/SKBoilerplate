class AssessmentQuestion {
  final String id;
  final String text;
  final QuestionCategory category;

  const AssessmentQuestion({
    required this.id,
    required this.text,
    this.category = QuestionCategory.shared,
  });

  factory AssessmentQuestion.fromJson(Map<String, dynamic> json) =>
      AssessmentQuestion(
        id: json['id'] as String,
        text: json['question'] as String,
        category: switch (json['category'] as String) {
          'android' => QuestionCategory.android,
          'ios' => QuestionCategory.ios,
          _ => QuestionCategory.shared,
        },
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': text,
    'category': category.name,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssessmentQuestion &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          category == other.category;

  @override
  int get hashCode => Object.hash(id, text, category);
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

enum QuestionCategory { android, ios, shared }
