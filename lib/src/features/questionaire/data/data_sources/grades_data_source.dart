import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/features/questionaire/data/models/response.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/device_grade.dart';

abstract interface class GradesDataSource {
  Future<DataResponse<DeviceGrade>> grade({required String quoteId, required AssessmentResponse response});
}
