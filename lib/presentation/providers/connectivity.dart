import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

enum ConnectivityStatus { connected, disconnected, Offline }

class ConnectivityService extends ChangeNotifier {
  late Connectivity _connectivity;

  ConnectivityStatus _status = ConnectivityStatus.disconnected;
  ConnectivityStatus get status => _status;

  ConnectivityService() {
    _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen(_updateStatus);
    _initializeStatus();
  }

  Future<void> _initializeStatus() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    _updateStatus(connectivityResult);
  }

  void _updateStatus(List<ConnectivityResult> results) {
    var result = results.isNotEmpty ? results.first : ConnectivityResult.none;
    _status = _convertResultToStatus(result);
    notifyListeners();
  }

  ConnectivityStatus _convertResultToStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        return ConnectivityStatus.connected;
      case ConnectivityResult.none:
      default:
        return ConnectivityStatus.disconnected;
    }
  }
}
