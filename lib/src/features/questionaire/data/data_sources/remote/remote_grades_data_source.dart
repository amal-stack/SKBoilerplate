import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/core/network/api_client.dart';
import 'package:boilerplate/src/core/network/models/api_request.dart';
import 'package:boilerplate/src/features/questionaire/data/data_sources/grades_data_source.dart';
import 'package:boilerplate/src/features/questionaire/data/models/response.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/device_grade.dart';

class RemoteGradesDataSource implements GradesDataSource {
  final ApiClient _client;

  RemoteGradesDataSource(this._client);

  @override
  Future<DataResponse<DeviceAssessmentResult>> grade({
    required String quoteId,
    required AssessmentResponse response,
  }) => _client
      .post(
        ApiRequest(
          path: '/questionnaires/$quoteId/get-grades',
          data: response.toJson(),
        ),
      )
      .then(
        (response) => DataResponse.fromJsonWithConverter(
          response.data as Map<String, dynamic>,
          dataFromJson: (data) => DeviceAssessmentResult.fromJson(data),
          dataToJson: (data) => data.toJson(),
        ),
      );
}
