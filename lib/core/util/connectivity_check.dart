import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityCheck {

  final Connectivity connectivity;

  // Constructor to inject the Connectivity dependency
  ConnectivityCheck({required this.connectivity});

  Future<bool> checkConnectivity() async {
    final List<ConnectivityResult> results = await connectivity.checkConnectivity();

    if (results.contains(ConnectivityResult.wifi)) {
      print("You are now connected to wifi");
      return true;
    } else if (results.contains(ConnectivityResult.mobile)) {
      print("You are now connected to mobile data");
      return true;
    } else if (results.contains(ConnectivityResult.vpn)) {
      print("You are now connected to vpn");
      return true;
    } else {
      print("No connection available");
      return false;
    }
  }
}
