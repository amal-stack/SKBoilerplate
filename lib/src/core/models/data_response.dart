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

  DataResponse.fromJson(super.json, {required DataFromJson<T> dataFromJson})
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
    Map<String, dynamic> json, {
    required DataFromJson<T> dataFromJson,
    required DataToJson<T> dataToJson,
  }) = _DataResponseWithConverter<T>.fromJson;

  // The additional data associated with the response.
  final T? data;

  T get requireData => data ?? (throw StateError('Data is null'));

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
    super.json, {
    required super.dataFromJson,
    required DataToJson<T> dataToJson,
  }) : dataToJsonConverter = dataToJson,
       super.fromJson();

  final DataToJson<T> dataToJsonConverter;

  @override
  Map<String, dynamic> dataToJson(T data) => dataToJsonConverter(data);
}

abstract class ListDataResponse<T> extends DataResponse<List<T>> {
  const ListDataResponse({
    required super.success,
    required super.message,
    required super.data,
  });

  ListDataResponse.fromJson(
    super.json, {
    required DataFromJson<T> itemFromJson,
    required String itemsKey,
  }) : super.fromJson(
         dataFromJson: (data) => [
           for (var item in (data[itemsKey] as List<dynamic>))
             itemFromJson(item as Map<String, dynamic>),
         ],
       );

  const factory ListDataResponse.withConverter({
    required bool success,
    required String message,
    required List<T>? data,
    required DataToJson<T> itemToJson,
  }) = ListDataResponseWithConverter<T>;

  factory ListDataResponse.fromJsonWithConverter(
    Map<String, dynamic> json, {
    required DataFromJson<T> itemFromJson,
    required String itemsKey,
    required DataToJson<T> itemToJson,
  }) = ListDataResponseWithConverter<T>.fromJson;

  @override
  List<Map<String, dynamic>> dataToJson(List<T> data) =>
      data.map(itemToJson).toList();

  Map<String, dynamic> itemToJson(T item);
}

final class ListDataResponseWithConverter<T> extends ListDataResponse<T> {
  const ListDataResponseWithConverter({
    required super.success,
    required super.message,
    required super.data,
    required DataToJson<T> itemToJson,
  }) : itemToJsonConverter = itemToJson;

  ListDataResponseWithConverter.fromJson(
    super.json, {
    required super.itemFromJson,
    required super.itemsKey,
    required DataToJson<T> itemToJson,
  }) : itemToJsonConverter = itemToJson,
       super.fromJson();

  final DataToJson<T> itemToJsonConverter;

  @override
  Map<String, dynamic> itemToJson(T item) => itemToJsonConverter(item);
}
