import 'package:boilerplate/src/features/questionaire/data/data_sources/quotes_data_source.dart';
import 'package:boilerplate/src/features/questionaire/data/models/quote.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/quote.dart';
import 'package:boilerplate/src/features/questionaire/domain/repositories/quotes_repository.dart';

class RemoteQuotesRepository implements QuotesRepository {
  const RemoteQuotesRepository(this.dataSource);

  final QuotesDataSource dataSource;

  @override
  Future<Quote> createQuote(CreateQuoteInput request) => dataSource
      .createQuote(
        CreateQuoteRequest(deviceId: request.deviceId, imei: request.imei),
      )
      .then((response) => response.requireData);

  @override
  Future<QuoteDeviceImages> saveDeviceImages({
    required String quoteId,
    required DeviceImages images,
  }) => dataSource
      .saveDeviceImages(quoteId: quoteId, images: images)
      .then((response) => response.requireData);

  @override
  Future<bool> saveDeviceInvoice({
    required String quoteId,
    required DeviceInvoice invoice,
  }) => dataSource
      .saveDeviceInvoice(quoteId: quoteId, invoice: invoice)
      .then((response) => response.success);
}
