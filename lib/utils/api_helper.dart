import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:employee_directory_app/models/employee_directory_model.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';



class ApiBaseHelper {

  static String baseUrl = "";


  Future<dynamic> getData() async {
    try {
      baseUrl = "http://www.mocky.io/v2/5d565297300000680030a986";
      http.Response response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        // List jsonResponse = json.decode(response.body);
        // return jsonResponse.map((employee) => EmployeeModel.fromJson(employee))
        //     .toList();
        return json.decode(response.body.toString());
      } else {
        throw Exception('Failed to load employee list from API');
      }
    } on SocketException {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        //print('No network');
        throw Exception('Please check your internet connection');
      } else {
        //print('Service not available');
        throw Exception('Service not available');
      }
    }
  }
}


