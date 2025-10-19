import 'package:boilerplate/src/features/orders/domain/entities/order.dart';
import 'package:boilerplate/src/features/orders/domain/repositories/orders_repository.dart';
import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrderCubit extends Cubit<ViewState<Order>> {
  CreateOrderCubit(this.repository, {required this.quoteId})
      : super(const ViewState.initial());

  final String quoteId;

  final OrdersRepository repository;

  Future<void> createOrder() async {
    emit(const ViewState.loading());

    try {
      final order = await repository.place(quoteId: quoteId);
      emit(ViewState.success(order));
    } catch (e, s) {
      emit(ViewState.error(e.toString()));
      debugPrint('Error creating order: $e');
      debugPrintStack(stackTrace: s);
    }
  }
  
}