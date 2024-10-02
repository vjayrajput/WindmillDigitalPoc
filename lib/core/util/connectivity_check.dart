import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

Future<bool> hasInternetAccess() async {
  try {
    final response = await http
        .get(Uri.parse('https://www.google.com'))
        .timeout(const Duration(seconds: 5));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

Future<bool> checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.none) {
    print('No Network Connection');
    return false;
  } else {
    // Check if there's actual internet access
    bool internetWorking = await hasInternetAccess();
    if (internetWorking) {
      print('Connected to the Internet');
      return true;
    } else {
      print('Connected to Network but No Internet');
      return false;
    }
  }
}
