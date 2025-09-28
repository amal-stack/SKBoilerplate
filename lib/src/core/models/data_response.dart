import 'package:boilerplate/src/core/models/response.dart';

typedef DataFromJson<T> = T Function(Map<String, dynamic> json);
typedef DataToJson<T> = Map<String, dynamic> Function(T data);


/// A [Response] that includes additional data.
abstract class DataResponse<T> extends Response {
  const DataResponse({
    required super.success,
    required super.message,
    required this.data,
  });

  DataResponse.fromJson(super.json, DataFromJson<T> dataFromJson)
    : data = json['data'] != null
          ? dataFromJson(json['data'] as Map<String, dynamic>)
          : null,
      super.fromJson();

  const factory DataResponse.withConverter({
    required bool success,
    required String message,
    required T? data,
    required DataToJson<T> dataToJsonConverter,
  }) = _DataResponseWithConverter<T>;

  factory DataResponse.fromJsonWithConverter(
    Map<String, dynamic> json,
    DataFromJson<T> dataFromJson,
    DataToJson<T> dataToJsonConverter,
  ) = _DataResponseWithConverter<T>.fromJson;

  // The additional data associated with the response.
  final T? data;

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    if (data case T d) 'data': dataToJson(d),
  };

  dynamic dataToJson(T data);
}

class _DataResponseWithConverter<T> extends DataResponse<T> {
  const _DataResponseWithConverter({
    required super.success,
    required super.message,
    required super.data,
    required this.dataToJsonConverter,
  });

  _DataResponseWithConverter.fromJson(
    super.json,
    super.dataFromJson,
    this.dataToJsonConverter,
  ) : super.fromJson();

  final DataToJson<T> dataToJsonConverter;

  @override
  Map<String, dynamic> dataToJson(T data) => dataToJsonConverter(data);
}
