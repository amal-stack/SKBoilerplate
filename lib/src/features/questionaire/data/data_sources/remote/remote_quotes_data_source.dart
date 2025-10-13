import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/core/models/response.dart';
import 'package:boilerplate/src/core/network/api_client.dart';
import 'package:boilerplate/src/core/network/models/api_request.dart';
import 'package:boilerplate/src/features/questionaire/data/data_sources/quotes_data_source.dart';
import 'package:boilerplate/src/features/questionaire/data/models/quote.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/quote.dart';
import 'package:dio/dio.dart' hide Response;
import 'package:flutter/foundation.dart';

class RemoteQuotesDataSource implements QuotesDataSource {
  final ApiClient _client;

  RemoteQuotesDataSource(this._client);

  @override
  Future<DataResponse<Quote>> createQuote(CreateQuoteRequest request) async {
    final response = await _client.post(
      ApiRequest(path: '/quotes/create', data: request.toJson()),
    );

    debugPrint('Response data: ${response.dataAsMap()}');

    return DataResponse.fromJsonWithConverter(
      response.dataAsMap(),
      dataFromJson: (data) => Quote.fromJson(data),
      dataToJson: (data) => data.toJson(),
    );
  }

}
