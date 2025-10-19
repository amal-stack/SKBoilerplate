import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/core/models/response.dart';
import 'package:boilerplate/src/features/orders/domain/entities/order.dart';

abstract interface class OrdersDataSource {
  Future<DataResponse<Order>> create({required String quoteId});

  Future<DataResponse<List<Order>>> history();

  Future<DataResponse<Order>> details({required String orderId});

  Future<Response> changeStatus({
    required String orderId,
    required OrderStatus status,
  });
}



