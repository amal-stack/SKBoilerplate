import 'package:boilerplate/src/features/questionaire/domain/entities/device_grade.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';

abstract interface class GradesRepository {
  Future<DeviceAssessmentResult> grade({
    required String quoteId,
    required DeviceAssessment assessment,
  });
}
