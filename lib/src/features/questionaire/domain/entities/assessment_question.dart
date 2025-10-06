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

