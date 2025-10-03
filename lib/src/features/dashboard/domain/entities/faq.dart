import 'package:meta/meta.dart';

@immutable
class Faq {
  const Faq({required this.id, required this.question, required this.answer});

  Faq.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        question = json['question'] as String,
        answer = json['answer'] as String;

  final int id;

  final String question;

  final String answer;

  Faq copyWith({int? id, String? question, String? answer}) => Faq(
    id: id ?? this.id,
    question: question ?? this.question,
    answer: answer ?? this.answer,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'answer': answer,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Faq &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          question == other.question &&
          answer == other.answer;

  @override
  int get hashCode => Object.hash(id, question, answer);
}
