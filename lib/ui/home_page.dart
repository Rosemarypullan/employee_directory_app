import 'dart:io';

import 'package:employee_directory_app/bloc/employee_directory_bloc.dart';
import 'package:employee_directory_app/models/employee_directory_model.dart';
import 'package:employee_directory_app/ui/employee_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final employeeListBloc = EmployeeListBloc();

  List<EmployeeModel> employeeList = [];
  late EmployeeListBloc bloc;
  bool isLoading= true;
  TextEditingController controller = new TextEditingController();

  List<EmployeeModel>? _searchResult = [];



  @override
  void initState() {
    super.initState();
    bloc = EmployeeListBloc();

    getEmployeesList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Directory App',
        theme: ThemeData(
        primarySwatch: Colors.teal,
        ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Employee Directory'),

        ),

        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(),
              Container(
                color: Theme.of(context).primaryColor,
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Card(
                    child:  ListTile(
                      leading:  Icon(Icons.search),
                      title:  TextField(
                        controller: controller,
                        decoration:  const InputDecoration(
                            hintText: 'Search', border: InputBorder.none),
                        onChanged: onSearchTextChanged,
                      ),
                      trailing:  IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                        controller.clear();
                        onSearchTextChanged('');
                      },),
                    ),
                  ),
                ),
              ),
              Expanded(child: getEmployeeListWidgets(),


              ),
            ],
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult!.clear();
    if (text.isEmpty) {
      FocusScope.of(context).unfocus();
      setState(() {});
      return;
    }

    employeeList.forEach((userDetail) {
      if (userDetail.name.toLowerCase().contains(text.toLowerCase()) || userDetail.email.toLowerCase().contains(text.toLowerCase())){
        _searchResult!.add(userDetail);
      }

    });

    setState(() {});
  }


  Future<void> getEmployeesList() async {
   // employeeList =   await bloc.getEmployeeList();

    if(employeeList!= null && employeeList.length>0){
      setState(() {

        isLoading = false;
      });
    }else{
      isLoading = false;
    }

  }



  Widget getEmployeeListWidgets() {

    return StreamBuilder(
        stream: bloc.getEmployeeList,
        builder: (context, AsyncSnapshot snapshot) {

          if (snapshot.hasData) {



            if (snapshot.data != null) {

              employeeList = snapshot.data;
              return showEmployeeList();
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.info, size: 40, color: Colors.grey),
                    Text(
                      'No Data Available',
                    )
                  ],
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.error_outline, size: 40, color: Colors.grey),
                  Text('Unable to fetch Data'),
                ],
              ),
            );
          }
          else {

            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });




  }

  Widget showEmployeeList() {
    if (employeeList != null && employeeList.length > 0) {
    return   _searchResult!.length != 0 || controller.text.isNotEmpty
          ? new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _searchResult!.length,
        itemBuilder: (context, index) {
          return listViewContents(_searchResult![index], index);
        })
          :

       ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: employeeList.length,
          itemBuilder: (context, index) {
            return listViewContents(employeeList[index], index);
          });

    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.info, size: 40, color: Colors.grey),
            Text(
                // 'No pax available!',
                'No Data Available'),
          ],
        ),
      );
    }
  }

  Widget listViewContents(EmployeeModel item, int index) {
    return InkWell(
      onTap: () {
        navigateToDetails(item);
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 4),
        color: Colors.white,
        child: Row(children: <Widget>[
          item.profileImage != null && item.profileImage.isNotEmpty
              ?
          Image.file(File(item.profileImage))
              : Image.asset('assets/images/Avatar.jpeg',scale: 7.6,),
           Container(
             padding: EdgeInsets.only(left:20),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                item.name != null ?Text(item.name,textScaleFactor: 1.5,style:TextStyle(color: Colors.indigo)): Container(),
                item.company != null ? Text(item.company!.name,textScaleFactor: 1.2) : Container(),
                item.email != null ? Text(item.email,textScaleFactor: 1.2) : Container(),
              ],
          ),
           ) ,

        ]),
      ),
    );
  }

  void navigateToDetails(EmployeeModel item) async {
    var status = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmployeeDetailsPage(
                  employeeModel: item,
                )));
  }
}
