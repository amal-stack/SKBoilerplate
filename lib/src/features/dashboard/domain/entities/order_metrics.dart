import 'package:meta/meta.dart';

@immutable
class OrderMetrics {
  const OrderMetrics({
    required this.ongoingOrders,
    required this.pendingOrders,
    required this.completedOrders,
  });

  OrderMetrics.fromJson(Map<String, dynamic> json)
      : ongoingOrders = int.parse(json['ongoingOrder'] as String? ?? '0'),
        pendingOrders = int.parse(json['pendingOrder'] as String? ?? '0'),
        completedOrders = int.parse(json['completedOrder'] as String? ?? '0');

  final int ongoingOrders;

  final int pendingOrders;

  final int completedOrders;

  OrderMetrics copyWith({
    int? ongoingOrders,
    int? pendingOrders,
    int? completedOrders,
  }) => OrderMetrics(
    ongoingOrders: ongoingOrders ?? this.ongoingOrders,
    pendingOrders: pendingOrders ?? this.pendingOrders,
    completedOrders: completedOrders ?? this.completedOrders,
  );

  Map<String, dynamic> toJson() => {
    'ongoingOrder': ongoingOrders,
    'pendingOrder': pendingOrders,
    'completedOrder': completedOrders,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderMetrics &&
          runtimeType == other.runtimeType &&
          ongoingOrders == other.ongoingOrders &&
          pendingOrders == other.pendingOrders &&
          completedOrders == other.completedOrders;

  @override
  int get hashCode =>
      Object.hash(ongoingOrders, pendingOrders, completedOrders);
}
