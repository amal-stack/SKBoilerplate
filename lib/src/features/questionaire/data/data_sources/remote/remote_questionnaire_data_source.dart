
import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/core/network/api_client.dart';
import 'package:boilerplate/src/core/network/models/api_request.dart';
import 'package:boilerplate/src/features/questionaire/data/data_sources/questionnaire_data_source.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';

class RemoteQuestionnaireDataSource implements QuestionnaireDataSource {
  final ApiClient _client;

  RemoteQuestionnaireDataSource(this._client);

  @override
  Future<ListDataResponse<AssessmentQuestion>> questions() async {
    final response = await _client.get(
      ApiRequest(path: '/questionnaires/get-questions'),
    );
    
    return ListDataResponse.fromJsonWithConverter(
      response.dataAsMap(),
      itemFromJson: (data) => AssessmentQuestion.fromJson(data),
      itemsKey: 'questions',
      itemToJson: (item) => item.toJson(),
    );
  }
}