import 'package:connectivity/connectivity.dart';

class Connection {
  static var sharedInstance = Connection();

  Future<ConnectivityResult> checkConnectivity() {
    var connectivityResult = (Connectivity().checkConnectivity());
    return connectivityResult;
  }
}
