import 'package:boilerplate/src/features/questionaire/data/data_sources/quotes_data_source.dart';
import 'package:boilerplate/src/features/questionaire/data/models/quote.dart';
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
}
