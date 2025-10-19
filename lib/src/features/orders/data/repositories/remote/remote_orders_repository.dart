import 'package:boilerplate/src/features/orders/data/data_sources/orders_data_source.dart';
import 'package:boilerplate/src/features/orders/domain/entities/order.dart';
import 'package:boilerplate/src/features/orders/domain/repositories/orders_repository.dart';

class RemoteOrdersRepository implements OrdersRepository {
  RemoteOrdersRepository(this._dataSource);

  final OrdersDataSource _dataSource;

  @override
  Future<Order> details({required String orderId}) => _dataSource
      .details(orderId: orderId)
      .then((response) => response.requireData);

  @override
  Future<List<Order>> history() =>
      _dataSource.history().then((response) => response.requireData);

  @override
  Future<Order> place({required String quoteId}) => _dataSource
      .create(quoteId: quoteId)
      .then((response) => response.requireData);

  @override
  Future<bool> changeStatus({
    required String orderId,
    required OrderStatus status,
  }) => _dataSource
      .changeStatus(orderId: orderId, status: status)
      .then((response) => response.success);
}
