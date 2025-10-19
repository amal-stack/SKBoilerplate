
import 'package:boilerplate/src/features/orders/domain/entities/order.dart';

abstract interface class OrdersRepository {
  Future<Order> place({required String quoteId});
  
  Future<List<Order>> history();

  Future<Order> details({required String orderId});

  Future<bool> changeStatus({
    required String orderId,
    required OrderStatus status,
  });
}