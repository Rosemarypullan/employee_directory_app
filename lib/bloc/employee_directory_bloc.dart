import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:employee_directory_app/models/employee_directory_model.dart';
import 'package:employee_directory_app/models/employee_response.dart';
import 'package:employee_directory_app/repository/employee_list_repository.dart';

import '../resourses/employee_list_dao.dart';
import 'block_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path/path.dart' as path;


class EmployeeListBloc extends BlocBase {

  EmployeeListRepository _employeeListRepository = EmployeeListRepository();

  StreamController<List<EmployeeModel>?> _streamController =
  StreamController<List<EmployeeModel>>();

  StreamSink<List<EmployeeModel>?> get employeeListSink =>
      _streamController.sink;

  Stream<List<EmployeeModel>?> get employeeListStream =>
      _streamController.stream;

  List<EmployeeModel>? _list =[];
EmployeeResponse _employeeResponse = EmployeeResponse();
  EmployeeListDao? employeeListDao = EmployeeListDao();
  bool showEmployeeList = false;
  bool isNetworkConnected = false;


  EmployeeListBloc() {
    getEmployeeList.listen((list) => _streamController.add(list));
  }

  Stream<List<EmployeeModel>?> get getEmployeeList async*{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {

      isNetworkConnected = false;
    } else if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){

      isNetworkConnected = true;
    }
    try {


      var employeeDataList = await employeeListDao!.getAllEntries();
      if (employeeDataList != null && employeeDataList.length > 0 ) {



           employeeListSink.add(employeeDataList);

           _list = employeeDataList;


      } else {
        if(isNetworkConnected) {
          try {

            _employeeResponse =   await _employeeListRepository.getEmployeeListMethod();
            _list = _employeeResponse.list;

            for (int i = 0; i < _list!.length; i++) {
              if(_list![i].profileImage!= null && _list![i].profileImage.isNotEmpty){
                String imageFile =  await _download(_list![i].profileImage,_list![i].name,_list![i].id);
                _list![i].profileImage = imageFile;
              }

              employeeListDao?.insert(_list![i]);
            }
            employeeListSink.add(_list!);
          }catch(e){
            print("exception in bloc"+e.toString());
          }
        }


      }


    } catch (e, s) {
     print(e);
    }
    yield _list;
  }

  Future<String> _download(String url, String name, int? id) async {

    var response = await http.get(Uri.parse(url));

    // Get the image name
    var imageName = id.toString();


    // Get the document directory path
    var appDir = await pathProvider.getApplicationDocumentsDirectory();

    // This is the saved image path
    // You can use it to display the saved image later
    var localPath = path.join(appDir.path, imageName);

    // Downloading
    var imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);
    return localPath;
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
