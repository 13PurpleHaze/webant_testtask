import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  final _controller = StreamController<bool>.broadcast();

  Stream<bool> get connectivityStream => _controller.stream;

  ConnectivityService() {
    InternetConnection().onStatusChange.listen((InternetStatus status) {
      _controller.add(InternetStatus.connected == status);
    });
  }

  void dispose() {
    _controller.close();
  }
}
