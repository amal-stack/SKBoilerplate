import 'package:meta/meta.dart';

@immutable
class DeviceGrade {
  const DeviceGrade(this.value);

  final String value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceGrade &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}

class DeviceAssessmentResult {
  const DeviceAssessmentResult({
    required this.grade,
    required this.totalQuestions,
    required this.price,
    required this.quoteUpated,
    required this.device,
  });

  DeviceAssessmentResult.fromJson(Map<String, dynamic> json)
    : grade = DeviceGrade(json['grade'] as String),

      totalQuestions = json['totalQuestions'] as int,
      price = (json['price'] as num).toDouble(),
      quoteUpated = json['quoteUpdated'] as bool,
      device = AssessedDevice.fromJson(json['device'] as Map<String, dynamic>);

  final DeviceGrade grade;

  final int totalQuestions;
  final double price;
  final bool quoteUpated;
  final AssessedDevice device;

  Map<String, dynamic> toJson() {
    return {
      'grade': grade.value,

      'totalQuestions': totalQuestions,
      'price': price,
      'quoteUpated': quoteUpated,
      'device': device.toJson(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceAssessmentResult &&
          runtimeType == other.runtimeType &&
          grade == other.grade &&
          totalQuestions == other.totalQuestions &&
          price == other.price &&
          quoteUpated == other.quoteUpated &&
          device == other.device;

  @override
  int get hashCode =>
      Object.hash(grade, totalQuestions, price, quoteUpated, device);

  DeviceAssessmentResult copyWith({
    DeviceGrade? grade,
    int? trueCount,
    int? totalQuestions,
    double? price,
    bool? quoteUpated,
    AssessedDevice? device,
  }) => DeviceAssessmentResult(
    grade: grade ?? this.grade,

    totalQuestions: totalQuestions ?? this.totalQuestions,
    price: price ?? this.price,
    quoteUpated: quoteUpated ?? this.quoteUpated,
    device: device ?? this.device,
  );
}

class AssessedDevice {
  const AssessedDevice({
    required this.id,
    required this.ram,
    required this.storage,
    required this.category,
    required this.model,
  });

  AssessedDevice.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String,
      ram = json['ram'] as String,
      storage = json['storage'] as String,
      category = json['deviceCategory'] as String,
      model = AssessedDeviceModel.fromJson(
        json['model'] as Map<String, dynamic>,
      );

  final String id;
  final String ram;
  final String storage;
  final String category;
  final AssessedDeviceModel model;

  Map<String, dynamic> toJson() => {
    'id': id,
    'ram': ram,
    'storage': storage,
    'deviceCategory': category,
    'model': model.toJson(),
  };
}

class AssessedDeviceModel {
  const AssessedDeviceModel({
    required this.id,
    required this.name,
    required this.brandId,
    required this.brandName,
  });

  AssessedDeviceModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String,
      name = json['name'] as String,
      brandId = json['brand']['id'] as String,
      brandName = json['brand']['name'] as String;

  final String id;

  final String name;

  final String brandId;

  final String brandName;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'brandId': brandId,
    'brandName': brandName,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssessedDeviceModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          brandId == other.brandId &&
          brandName == other.brandName;

  @override
  int get hashCode => Object.hash(id, name, brandId, brandName);
}
