import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

class Config{
  static Logger logger = Logger( printer: PrettyPrinter(methodCount: 0));
  static bool isNetworkeConnected  =false;

  static Future<bool> checkNetworkConnection() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {

      isNetworkeConnected = false;

    } else if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){

      isNetworkeConnected = true;
    }
    return isNetworkeConnected;
  }


}