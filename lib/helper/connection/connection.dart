import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectionUtils {
  static Future<bool> isNetworkConnected() async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    for (ConnectivityResult result in connectivityResult) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          (kDebugMode && result == ConnectivityResult.ethernet)) {
        return true;
      }
    }
    return false;
  }
}
