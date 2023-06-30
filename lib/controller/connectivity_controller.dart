import 'package:browser_app/modals/connectivity_modal.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class ConnectivityProvider extends ChangeNotifier {


  String selectedOption = "Option 1";
  List bookMark = [];
  List urlBookmark1 = [];
  String urlBookmark = "";
  TextEditingController searchController = TextEditingController();


  Connectivity connectivity = Connectivity();
  ConnectivityModal connectivityModal = ConnectivityModal(connectivityStatus: "Waiting");

  void checkInternetConnectivity() {
    connectivityModal.connectivityStream = connectivity.onConnectivityChanged.
    listen((ConnectivityResult connectivityResult) {
      switch (connectivityResult) {

        case ConnectivityResult.wifi:
          connectivityModal.connectivityStatus = "wifi";
        notifyListeners();
        break;

        case ConnectivityResult.mobile:
          connectivityModal.connectivityStatus = "Mobile Data";
          notifyListeners();
          break;

        default:
          connectivityModal.connectivityStatus = "Waiting";
          notifyListeners();
          break;
      }
    });
  }
}