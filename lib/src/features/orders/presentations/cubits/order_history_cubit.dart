import 'package:boilerplate/src/features/orders/domain/entities/order.dart'
    show Order, OrderStatus;
import 'package:boilerplate/src/features/orders/domain/repositories/orders_repository.dart';
import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistoryCubit extends Cubit<ViewState<OrderHistoryState>> {
  OrderHistoryCubit(this.repository) : super(const ViewState.initial());

  final OrdersRepository repository;

  Future<void> fetchOrderHistory({String? orderIdQuery}) async {
    emit(const ViewState.loading());
    try {
      Iterable<Order> orders = await repository.history();

      if (orderIdQuery?.isNotEmpty ?? false) {
        orders = orders.where(
          (order) =>
              order.id.toLowerCase().contains(orderIdQuery!.toLowerCase()),
        );
      }
      final pendingOrders = orders
          .where(OrderHistoryFilter.pending.predicate)
          .toList();
      final ongoingOrders = orders
          .where(OrderHistoryFilter.ongoing.predicate)
          .toList();
      final completedOrders = orders
          .where(OrderHistoryFilter.completed.predicate)
          .toList();

      emit(
        ViewState.success(
          OrderHistoryState(
            pendingOrders: pendingOrders,
            ongoingOrders: ongoingOrders,
            completedOrders: completedOrders,
          ),
        ),
      );
    } catch (e, s) {
      emit(ViewState.error(e.toString()));
      debugPrintStack(stackTrace: s);
    }
  }
}

enum OrderHistoryFilter {
  all,
  pending,
  completed,
  ongoing;

  bool Function(Order) get predicate => switch (this) {
    OrderHistoryFilter.all => (_) => true,
    OrderHistoryFilter.pending =>
      (order) =>
          order.status.representation == OrderStatus.pending.representation,
    OrderHistoryFilter.completed =>
      (order) =>
          order.status.representation == OrderStatus.completed.representation,
    OrderHistoryFilter.ongoing =>
      (order) => order.status.representation == 'ONGOING',
  };
}

class OrderHistoryState {
  const OrderHistoryState({
    required this.pendingOrders,
    required this.ongoingOrders,
    required this.completedOrders,
  });

  final List<Order> pendingOrders;

  final List<Order> ongoingOrders;

  final List<Order> completedOrders;
}
