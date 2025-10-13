import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/core/models/response.dart';
import 'package:boilerplate/src/core/network/api_client.dart';
import 'package:boilerplate/src/core/network/models/api_request.dart';
import 'package:boilerplate/src/features/questionaire/data/data_sources/quotes_data_source.dart';
import 'package:boilerplate/src/features/questionaire/data/models/quote.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/quote.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

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

  @override
  Future<DataResponse<QuoteDeviceImages>> saveDeviceImages({
    required String quoteId,
    required DeviceImages images,
  }) async {
    final response = await _client.post(
      ApiRequest(
        path: '/quotes/$quoteId/upload-device-images',
        data: ApiFormData(
          fields: {'quoteId': quoteId},
          files: [
            ApiFileEntry.multiple(
              key: 'images',
              files: [
                ApiFile(
                  path: images.front,
                  filename: '$quoteId-front.${p.extension(images.front)}',
                ),
                ApiFile(
                  path: images.back,
                  filename: '$quoteId-back.${p.extension(images.back)}',
                ),
                ApiFile(
                  path: images.left,
                  filename: '$quoteId-left.${p.extension(images.left)}',
                ),
                ApiFile(
                  path: images.right,
                  filename: '$quoteId-right.${p.extension(images.right)}',
                ),
                ApiFile(
                  path: images.top,
                  filename: '$quoteId-top.${p.extension(images.top)}',
                ),
                ApiFile(
                  path: images.bottom,
                  filename: '$quoteId-bottom.${p.extension(images.bottom)}',
                ),
              ],
            ),
          ],
        ),
      ),
    );

    debugPrint('Response data: ${response.dataAsMap()}');

    return DataResponse.fromJsonWithConverter(
      response.dataAsMap(),
      dataFromJson: (data) => QuoteDeviceImages.fromJson(data),
      dataToJson: (data) => data.toJson(),
    );
  }

  @override
  Future<Response> saveDeviceInvoice({
    required String quoteId,
    required DeviceInvoice invoice,
  }) async {
    final response = await _client.post(
      ApiRequest(
        path: '/quotes/$quoteId/upload-invoice',
        data: ApiFormData(
          fields: {'quoteId': quoteId},
          files: [
            ApiFileEntry(
              key: 'invoice',
              filename: '$quoteId-invoice.${p.extension(invoice.path)}',
              path: invoice.path,
            ),
          ],
        ),
      ),
    );

    debugPrint('Response data: ${response.dataAsMap()}');

    return Response.fromJson(response.dataAsMap());
  }
}
