import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/core/models/response.dart';
import 'package:boilerplate/src/core/network/api_client.dart';
import 'package:boilerplate/src/core/network/models/api_request.dart';
import 'package:boilerplate/src/features/orders/data/data_sources/orders_data_source.dart';
import 'package:boilerplate/src/features/orders/domain/entities/order.dart';

class RemoteOrdersDataSource implements OrdersDataSource {
  const RemoteOrdersDataSource(this._client);

  final ApiClient _client;

  @override
  Future<Response> changeStatus({
    required String orderId,
    required OrderStatus status,
  }) => _client
      .put(
        ApiRequest(
          path: '/orders/$orderId/status',
          data: {'status': status.representation},
        ),
      )
      .then((response) => Response.fromJson(response.dataAsMap()));

  @override
  Future<DataResponse<Order>> create({required String quoteId}) => _client
      .post(ApiRequest(path: '/orders/create', data: {'quoteId': quoteId}))
      .then(
        (response) => DataResponse.fromJsonWithConverter(
          response.dataAsMap(),
          dataFromJson: (data) =>
              Order.fromJson(data['order'] as Map<String, dynamic>),
          dataToJson: (data) => {'order': data.toJson()},
        ),
      );

  @override
  Future<DataResponse<Order>> details({required String orderId}) {
    return _client
        .get(ApiRequest(path: '/orders/$orderId'))
        .then(
          (response) => DataResponse.fromJsonWithConverter(
            response.dataAsMap(),
            dataFromJson: Order.fromJson,
            dataToJson: (data) => data.toJson(),
          ),
        );
  }

  @override
  Future<ListDataResponse<Order>> history() => _client
      .get(ApiRequest(path: '/orders/history'))
      .then(
        (response) => ListDataResponse.fromJsonWithConverter(
          response.dataAsMap(),
          itemFromJson: (json) => Order.fromJson(json),
          itemToJson: (data) => data.toJson(),
          itemsKey: 'orders',
        ),
      );
}
