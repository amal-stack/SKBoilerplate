import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/shared/paginated.dart';

abstract class PaginatedResponse<T>
    extends DataResponse<PaginatedResponseData<T>> {
  const PaginatedResponse({
    required super.success,
    required super.message,
    required super.data,
  });

  PaginatedResponse.fromJson(
    super.json, {
    required DataFromJson<T> itemFromJson,
    required String itemsKey,
  }) : super.fromJson(
         dataFromJson: (data) => PaginatedResponseData.fromJson(
           data,
           itemFromJson: itemFromJson,
           itemsKey: itemsKey,
         ),
       );

  Paginated<T> toPaginated() => switch (data) {
    final data? => Paginated(
      data.items,
      page: data.pagination.page,
      limit: data.pagination.limit,
      total: data.pagination.total,
      totalPages: data.pagination.totalPages,
    ),
    null => throw StateError(
      'No response data available to convert to Paginated',
    ),
  };

  @override
  dynamic dataToJson(PaginatedResponseData<T> data) => data.toJson(itemToJson);

  Map<String, dynamic> itemToJson(T item);

  @override
  Map<String, dynamic> toJson() => {...super.toJson()};
}

class PaginatedResponseData<T> {
  const PaginatedResponseData({required this.items, required this.pagination});

  PaginatedResponseData.fromJson(
    Map<String, dynamic> json, {
    required DataFromJson<T> itemFromJson,
    required String itemsKey,
  }) : items = [
         for (var item in (json[itemsKey] as List<dynamic>))
           itemFromJson(item as Map<String, dynamic>),
       ],
       pagination = ResponsePagination.fromJson(
         json['pagination'] as Map<String, dynamic>,
       );

  final List<T> items;

  final ResponsePagination pagination;

  Map<String, dynamic> toJson(
    DataToJson<T> itemToJson, {
    String itemsKey = 'items',
  }) => {
    itemsKey: [for (var item in items) itemToJson(item)],
    'pagination': pagination.toJson(),
  };
}

class ResponsePagination {
  const ResponsePagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  ResponsePagination.fromJson(Map<String, dynamic> json)
    : page = json['page'] as int,
      limit = json['limit'] as int,
      total = json['total'] as int,
      totalPages = json['pages'] as int;

  final int page;

  final int limit;

  final int total;

  final int totalPages;

  Map<String, dynamic> toJson() => {
    'page': page,
    'limit': limit,
    'total': total,
    'totalPages': totalPages,
  };
}
