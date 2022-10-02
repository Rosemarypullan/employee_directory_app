

import 'package:employee_directory_app/models/employee_directory_model.dart';

abstract class AllEmployeesRepository {
  insert(EmployeeModel usersDetailsList);
  Future delete(String key);
  Future<List<EmployeeModel>> getAllEntries();
}
