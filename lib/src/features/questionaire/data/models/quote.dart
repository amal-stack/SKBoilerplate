class CreateQuoteRequest {
  const CreateQuoteRequest({
    required this.deviceId,
    required this.imei,
  });

  CreateQuoteRequest.fromJson(Map<String, dynamic> json)
    : deviceId = json['deviceId'] as String,
      imei = json['imei'] as String;

  final String deviceId;

  final String imei;

  Map<String, dynamic> toJson() => {
    'deviceId': deviceId,
    'imei': imei,
  };
}