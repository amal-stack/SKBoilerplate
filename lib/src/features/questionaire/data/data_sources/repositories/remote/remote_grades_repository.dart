import 'package:boilerplate/src/features/questionaire/data/data_sources/grades_data_source.dart';
import 'package:boilerplate/src/features/questionaire/data/models/response.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/device_grade.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/domain/repositories/grades_repository.dart';

class RemoteGradesRepository implements GradesRepository {
  final GradesDataSource dataSource;

  RemoteGradesRepository(this.dataSource);

  @override
  Future<DeviceAssessmentResult> grade({
    required String quoteId,
    required DeviceAssessment assessment,
  }) => dataSource
      .grade(
        quoteId: quoteId,
        response: AssessmentResponse.fromAssessment(assessment),
      )
      .then((response) => response.requireData);
}
