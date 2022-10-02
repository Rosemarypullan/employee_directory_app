import 'package:employee_directory_app/models/employee_directory_model.dart';
import 'package:employee_directory_app/repository/employees_details_repository.dart';

import 'package:sembast/sembast.dart';

import '../utils/app_database.dart';

class EmployeeListDao extends AllEmployeesRepository {
  static const String tableName = "EmployeeDetails";
  final _allEmployeesTable = stringMapStoreFactory.store(tableName);

  Future<Database> get _db async => await AppDatabase.instance.database;
  @override
  insert(EmployeeModel item) async {
    Map<String, dynamic> map = item.toJson();
    String key = map['id'].toString() +
        "_" +
        map["username"] ;

    await _allEmployeesTable
        .record(key)
        .put(await _db, map, merge: true);
  }

  @override
  Future update(EmployeeModel item) async {}
  @override
  Future delete(String key) async {
    var deletedRow =
    await _allEmployeesTable.record(key).delete(await _db);
  }

  @override
  Future<List<EmployeeModel>> getAllEntries() async {
    final recordSnapshot = await _allEmployeesTable.find(await _db);
    return recordSnapshot.map(
          (snapshot) {
        final item = EmployeeModel.fromJson(snapshot.value);
        return item;
      },
    ).toList();
  }
}
