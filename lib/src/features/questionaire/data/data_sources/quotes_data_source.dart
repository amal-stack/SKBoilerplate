import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/core/models/response.dart';
import 'package:boilerplate/src/features/questionaire/data/models/quote.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/quote.dart';

abstract interface class QuotesDataSource {
  Future<DataResponse<Quote>> createQuote(CreateQuoteRequest request);

  // Future<Response> saveDeviceImages({
  //   required String quoteId,
  //   required DeviceImages images,
  // });

  // Future<Response> saveDeviceInvoice({
  //   required String quoteId,
  //   required DeviceInvoice invoice,
  // });
}


