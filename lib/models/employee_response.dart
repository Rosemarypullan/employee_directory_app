import 'package:employee_directory_app/models/employee_directory_model.dart';

class EmployeeResponse {
  List<EmployeeModel>? list;


  EmployeeResponse({
    this.list,

  });

  EmployeeResponse.fromJson(List<dynamic> json) {
    if (json != null && json.length > 0) {
      list = <EmployeeModel>[];
      json.forEach((employee) {
        list!.add(EmployeeModel.fromJson(employee));
      });
    }
  }



  Map<String, dynamic> toJson() {
    final List allemployees = [];
    final Map<String, dynamic> data = new Map<String, dynamic>();
    for (int i = 0; i < list!.length; i++) {
      allemployees.add(list![i].toJson());
    }

    return data;
  }
}

