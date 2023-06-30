import 'dart:async';

class ConnectivityModal {

  String connectivityStatus;
  StreamSubscription? connectivityStream;

  ConnectivityModal({
    required this.connectivityStatus,
    this.connectivityStream,
});
}