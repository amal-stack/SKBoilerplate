import 'package:meta/meta.dart';

@immutable
class DeviceGrade {
  const DeviceGrade(this.value);

  final String value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceGrade &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}

class DeviceAssessmentResult {
  const DeviceAssessmentResult({
    required this.grade,
    required this.trueCount,
    required this.totalQuestions,
    required this.price,
    required this.quoteUpated,
  });

  DeviceAssessmentResult.fromJson(Map<String, dynamic> json)
    : grade = DeviceGrade(json['grade'] as String),
      trueCount = json['trueCount'] as int,
      totalQuestions = json['totalQuestions'] as int,
      price = (json['price'] as num).toDouble(),
      quoteUpated = json['quoteUpated'] as bool;

  final DeviceGrade grade;

  final int trueCount;
  final int totalQuestions;
  final double price;
  final bool quoteUpated;

  Map<String, dynamic> toJson() {
    return {
      'grade': grade.value,
      'trueCount': trueCount,
      'totalQuestions': totalQuestions,
      'price': price,
      'quoteUpated': quoteUpated,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceAssessmentResult &&
          runtimeType == other.runtimeType &&
          grade == other.grade &&
          trueCount == other.trueCount &&
          totalQuestions == other.totalQuestions &&
          price == other.price &&
          quoteUpated == other.quoteUpated;
  @override
  int get hashCode =>
      Object.hash(grade, trueCount, totalQuestions, price, quoteUpated);

  DeviceAssessmentResult copyWith({
    DeviceGrade? grade,
    int? trueCount,
    int? totalQuestions,
    double? price,
    bool? quoteUpated,
  }) => DeviceAssessmentResult(
    grade: grade ?? this.grade,
    trueCount: trueCount ?? this.trueCount,
    totalQuestions: totalQuestions ?? this.totalQuestions,
    price: price ?? this.price,
    quoteUpated: quoteUpated ?? this.quoteUpated,
  );
}
