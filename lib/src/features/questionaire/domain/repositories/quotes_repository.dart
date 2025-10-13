import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/quote.dart';

abstract interface class QuotesRepository {
  Future<Quote> createQuote(CreateQuoteInput input);

  Future<QuoteDeviceImages> saveDeviceImages({
    required String quoteId,
    required DeviceImages images,
  });

  Future<bool> saveDeviceInvoice({
    required String quoteId,
    required DeviceInvoice invoice,
  });
}

class CreateQuoteInput {
  const CreateQuoteInput({required this.deviceId, required this.imei});

  CreateQuoteInput.fromJson(Map<String, dynamic> json)
    : deviceId = json['deviceId'] as String,
      imei = json['imei'] as String;

  final String deviceId;

  final String imei;

  Map<String, dynamic> toJson() => {'deviceId': deviceId, 'imei': imei};
}
