class Order {
  const Order({
    required this.id,
    required this.oId,
    required this.quoteId,
    required this.kycId,
    this.kycName,
    required this.kycNumber,
    required this.deviceBrand,
    required this.deviceModel,
    required this.deviceVariant,
    required this.devicePrice,
    required this.deviceGrade,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String oId;
  final String quoteId;
  final String kycId;
  final String? kycName;
  final String kycNumber;
  final String deviceBrand;
  final String deviceModel;
  final String deviceVariant;
  final int? devicePrice;
  final String? deviceGrade;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'] as String,
        oId: json['oId'] as String,
        quoteId: json['quoteId'] as String,
        kycId: json['kycId'] as String,
        kycName: json['kycName'] as String?,
        kycNumber: json['kycNumber'] as String,
        deviceBrand: json['deviceBrand'] as String,
        deviceModel: json['deviceModel'] as String,
        deviceVariant: json['deviceVariant'] as String,
        devicePrice: json['devicePrice'] as int?,
        deviceGrade: json['deviceGrade'] as String?,
        status: OrderStatus.fromRepresentation(json['status'] as String),
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'oId': oId,
    'quoteId': quoteId,
    'kycId': kycId,
    'kycName': kycName,
    'kycNumber': kycNumber,
    'deviceBrand': deviceBrand,
    'deviceModel': deviceModel,
    'deviceVariant': deviceVariant,
    'devicePrice': devicePrice,
    'deviceGrade': deviceGrade,
    'status': status.representation,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  Order copyWith({
    String? id,
    String? oId,
    String? quoteId,
    String? kycId,
    String? kycName,
    String? kycNumber,
    String? deviceBrand,
    String? deviceModel,
    String? deviceVariant,
    int? devicePrice,
    String? deviceGrade,
    OrderStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Order(
    id: id ?? this.id,
    oId: oId ?? this.oId,
    quoteId: quoteId ?? this.quoteId,
    kycId: kycId ?? this.kycId,
    kycName: kycName ?? this.kycName,
    kycNumber: kycNumber ?? this.kycNumber,
    deviceBrand: deviceBrand ?? this.deviceBrand,
    deviceModel: deviceModel ?? this.deviceModel,
    deviceVariant: deviceVariant ?? this.deviceVariant,
    devicePrice: devicePrice ?? this.devicePrice,
    deviceGrade: deviceGrade ?? this.deviceGrade,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          oId == other.oId &&
          quoteId == other.quoteId &&
          kycId == other.kycId &&
          kycName == other.kycName &&
          kycNumber == other.kycNumber &&
          deviceBrand == other.deviceBrand &&
          deviceModel == other.deviceModel &&
          deviceVariant == other.deviceVariant &&
          devicePrice == other.devicePrice &&
          deviceGrade == other.deviceGrade &&
          status == other.status &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
    id,
    oId,
    quoteId,
    kycId,
    kycName,
    kycNumber,
    deviceBrand,
    deviceModel,
    deviceVariant,
    devicePrice,
    deviceGrade,
    status,
    createdAt,
    updatedAt,
  );
}

// PENDING - Order is pending and waiting to be processed
// PROCESSING - Order is being processed
// PICKUP_ASSIGNED - Pickup has been assigned to a delivery partner
// PICKUP_AWAITED - Waiting for pickup to be completed
// PICKUP_COMPLETED - Pickup has been completed successfully
// PICKUP_REJECTED - Pickup was rejected
// PAYMENT_PROCESSED - Payment has been processed successfully
// COMPLETED - Order has been completed successfully
// CANCELLED

enum OrderStatus {
  pending,
  processing,
  pickupAssigned,
  pickupAwaited,
  pickupCompleted,
  pickupRejected,
  paymentProcessed,
  completed,
  cancelled;

  bool get isOngoing =>
      this == OrderStatus.processing ||
      this == OrderStatus.pickupAssigned ||
      this == OrderStatus.pickupAwaited ||
      this == OrderStatus.pickupCompleted ||
      this == OrderStatus.paymentProcessed;

  factory OrderStatus.fromRepresentation(String status) =>
      switch (status.toLowerCase()) {
        'pending' => OrderStatus.pending,
        'processing' => OrderStatus.processing,
        'pickup_assigned' => OrderStatus.pickupAssigned,
        'pickup_awaited' => OrderStatus.pickupAwaited,
        'pickup_completed' => OrderStatus.pickupCompleted,
        'pickup_rejected' => OrderStatus.pickupRejected,
        'payment_processed' => OrderStatus.paymentProcessed,
        'completed' => OrderStatus.completed,
        'cancelled' => OrderStatus.cancelled,
        _ => throw ArgumentError('Invalid order status: $status'),
      };

  String get representation => switch (this) {
    OrderStatus.pending => 'PENDING',
    OrderStatus.processing => 'PROCESSING',
    OrderStatus.pickupAssigned => 'PICKUP_ASSIGNED',
    OrderStatus.pickupAwaited => 'PICKUP_AWAITED',
    OrderStatus.pickupCompleted => 'PICKUP_COMPLETED',
    OrderStatus.pickupRejected => 'PICKUP_REJECTED',
    OrderStatus.paymentProcessed => 'PAYMENT_PROCESSED',
    OrderStatus.completed => 'COMPLETED',
    OrderStatus.cancelled => 'CANCELLED',
  };
}
