class Quote {
  const Quote({
    required this.id,
    required this.imei,
    required this.deviceId,
    required this.userId,
    this.vendorId,
    this.storeId,
    required this.userName,
    required this.userEmail,
    this.userPhone,
    this.frontImageUrl,
    this.backImageUrl,
    this.leftImageUrl,
    this.rightImageUrl,
    this.topImageUrl,
    this.bottomImageUrl,
    this.invoiceImageUrl,
    this.questionnaireResponses,
    this.grade,
    this.trueCount,
    this.totalQuestions,
    this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.device,
    this.vendor,
    this.store,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    id: json['id'] as String,
    imei: json['imei'] as String,
    deviceId: json['deviceId'] as String,
    userId: json['userId'] as String,
    vendorId: json['vendorId'] as String?,
    storeId: json['storeId'] as String?,
    userName: json['userName'] as String,
    userEmail: json['userEmail'] as String,
    userPhone: json['userPhone'] as String?,
    frontImageUrl: json['frontImageUrl'] as String?,
    backImageUrl: json['backImageUrl'] as String?,
    leftImageUrl: json['leftImageUrl'] as String?,
    rightImageUrl: json['rightImageUrl'] as String?,
    topImageUrl: json['topImageUrl'] as String?,
    bottomImageUrl: json['bottomImageUrl'] as String?,
    invoiceImageUrl: json['invoiceImageUrl'] as String?,
    questionnaireResponses: json['questionnaireResponses'],
    grade: json['grade'] as String?,
    trueCount: json['trueCount'] as int?,
    totalQuestions: json['totalQuestions'] as int?,
    price: json['price'] as double?,
    status: json['status'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
    device: QuoteDevice.fromJson(json['device'] as Map<String, dynamic>),
    vendor: json['vendor'],
    store: json['store'],
  );

  final String id;
  final String imei;
  final String deviceId;
  final String userId;
  final String? vendorId;
  final String? storeId;
  final String userName;
  final String userEmail;
  final String? userPhone;
  final String? frontImageUrl;
  final String? backImageUrl;
  final String? leftImageUrl;
  final String? rightImageUrl;
  final String? topImageUrl;
  final String? bottomImageUrl;
  final String? invoiceImageUrl;
  final dynamic questionnaireResponses;
  final String? grade;
  final int? trueCount;
  final int? totalQuestions;
  final double? price;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final QuoteDevice device;
  final dynamic vendor;
  final dynamic store;

  Map<String, dynamic> toJson() => {
    'id': id,
    'imei': imei,
    'deviceId': deviceId,
    'userId': userId,
    'vendorId': vendorId,
    'storeId': storeId,
    'userName': userName,
    'userEmail': userEmail,
    'userPhone': userPhone,
    'frontImageUrl': frontImageUrl,
    'backImageUrl': backImageUrl,
    'leftImageUrl': leftImageUrl,
    'rightImageUrl': rightImageUrl,
    'topImageUrl': topImageUrl,
    'bottomImageUrl': bottomImageUrl,
    'invoiceImageUrl': invoiceImageUrl,
    'questionnaireResponses': questionnaireResponses,
    'grade': grade,
    'trueCount': trueCount,
    'totalQuestions': totalQuestions,
    'price': price,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'device': device.toJson(),
    'vendor': vendor,
    'store': store,
  };
}

class QuoteDevice {
  const QuoteDevice({
    required this.id,
    required this.modelId,
    required this.ram,
    required this.storage,
    required this.model,
  });

  factory QuoteDevice.fromJson(Map<String, dynamic> json) => QuoteDevice(
    id: json['id'] as String,
    modelId: json['modelId'] as String,
    ram: json['ram'] as String,
    storage: json['storage'] as String,
    model: DeviceModel.fromJson(json['model'] as Map<String, dynamic>),
  );

  final String id;
  final String modelId;
  final String ram;
  final String storage;
  final DeviceModel model;

  Map<String, dynamic> toJson() => {
    'id': id,
    'modelId': modelId,
    'ram': ram,
    'storage': storage,
    'model': model.toJson(),
  };
}

class DeviceModel {
  const DeviceModel({
    required this.id,
    required this.brandId,
    required this.name,
    required this.brand,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
    id: json['id'] as String,
    brandId: json['brandId'] as String,
    name: json['name'] as String,
    brand: DeviceBrand.fromJson(json['brand'] as Map<String, dynamic>),
  );

  final String id;
  final String brandId;
  final String name;
  final DeviceBrand brand;

  Map<String, dynamic> toJson() => {
    'id': id,
    'brandId': brandId,
    'name': name,
    'brand': brand.toJson(),
  };
}

class DeviceBrand {
  const DeviceBrand({required this.id, required this.name});

  factory DeviceBrand.fromJson(Map<String, dynamic> json) =>
      DeviceBrand(id: json['id'] as String, name: json['name'] as String);

  final String id;
  final String name;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
