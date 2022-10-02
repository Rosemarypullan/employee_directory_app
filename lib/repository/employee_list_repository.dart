import 'package:employee_directory_app/models/employee_directory_model.dart';
import 'package:employee_directory_app/resourses/employee_list_dao.dart';
import 'package:employee_directory_app/utils/config.dart';
import 'package:logger/logger.dart';

import 'dart:convert';

import '../models/employee_response.dart';
import '../utils/api_helper.dart';

class EmployeeListRepository {
  ApiBaseHelper _helper = ApiBaseHelper();


  Future getEmployeeListMethod() async {



    final response = await _helper.getData();


   return EmployeeResponse.fromJson(response);
  }
}
