class QuestionnairePriceStore {
  QuestionnairePriceStore._();

  final Map<String, dynamic> _store = {};

  static final QuestionnairePriceStore instance = QuestionnairePriceStore._();

  void saveMaximumDevicePrice(String deviceId, num price) {
    _store['max_price'] = price;
  }

  num? maximumDevicePrice(String deviceId) =>
      _store['max_price'] as num?;

  void saveCalculatedDevicePrice(String deviceId, num price) {
    _store['calculated_price'] = price;
  }

  num? calculatedDevicePrice(String deviceId) =>
      _store['calculated_price'] as num?;

  void clear() {
    _store.clear();
  }
}
