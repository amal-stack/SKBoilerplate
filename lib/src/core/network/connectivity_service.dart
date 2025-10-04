import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
  ConnectivityService._internal();
  static final ConnectivityService instance = ConnectivityService._internal();

  static Future<void> initialize() async {
    await instance._init();
  }

  final _controller = StreamController<bool>.broadcast();
  Stream<bool> get connectionStream => _controller.stream;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;
  StreamSubscription<InternetConnectionStatus>? _internetSub;

  Future<void> _init() async {
    // Connectivity type change
    _connectivitySub =
        Connectivity().onConnectivityChanged.listen((_) async {
      final has = await InternetConnectionChecker.instance.hasConnection;
      _controller.add(has);
    });

    // Periodic checks
    _internetSub =
        InternetConnectionChecker.instance.onStatusChange.listen((status) {
      _controller.add(status == InternetConnectionStatus.connected);
    });

    // Initial check
    final initial = await InternetConnectionChecker.instance.hasConnection;
    _controller.add(initial);
  }

  void dispose() {
    _connectivitySub?.cancel();
    _internetSub?.cancel();
    _controller.close();
  }
}
