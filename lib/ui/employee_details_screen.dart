import 'dart:io';

import 'package:employee_directory_app/models/employee_directory_model.dart';
import 'package:flutter/material.dart';

class EmployeeDetailsPage extends StatefulWidget {
  EmployeeModel employeeModel;

  EmployeeDetailsPage({required this.employeeModel});

  @override
  EmployeeDetailsState createState() =>
      EmployeeDetailsState(employeeModel: employeeModel);
}

class EmployeeDetailsState extends State<EmployeeDetailsPage> {
  EmployeeModel employeeModel;

  EmployeeDetailsState({required this.employeeModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Employee details"),
        ),
        body: SingleChildScrollView(
          child: Column(children: [

            employeeModel.profileImage != null &&
                    employeeModel.profileImage.isNotEmpty
                ? Container(
                width: MediaQuery.of(context).size.width,
       child: Center(child:
       //Image.network(employeeModel.profileImage,scale: .325))):
        Image.file(File(employeeModel.profileImage),scale: .325))):

            Image.asset('assets/images/Avatar.jpeg',scale :2.4 ),

            employeeModel.name != null
                ? Container(
              padding: EdgeInsets.only(top:20),
                child: Text( employeeModel.name,textScaleFactor: 2,style:TextStyle(color: Colors.indigo)))
                : Container(),
            employeeModel.username != null
                ? Container(
              padding: const EdgeInsets.only(left :25, top: 25),
                  child: Align(
                  alignment: Alignment. topLeft,
                  child: Text("User Name         : " + employeeModel.username,textScaleFactor: 1.25)),
                )
                : Container(),
            employeeModel.phone != null && employeeModel.phone.isNotEmpty
                ? Align(
              alignment: Alignment. topLeft,
                  child: Container(
                  padding: const EdgeInsets.only(left :25, top: 10),
                  child: Text("Phone                   : " + employeeModel.phone,textScaleFactor: 1.2)),
                )
                : Align(
              alignment: Alignment. topLeft,
                  child: Container(
                  padding: const EdgeInsets.only(left :25, top: 10),
                  child: Text("Phone                   : Not available" ,textScaleFactor: 1.2)),
                ),
            employeeModel.email != null
                ? Align(
                alignment: Alignment. topLeft,
    child: Container(
    padding: const EdgeInsets.only(left :25, top: 10),
    child:Text("Email                    : " + employeeModel.email,textScaleFactor: 1.2)))
                : Container(),
            employeeModel.address != null
                ? Align(
                alignment: Alignment. topLeft,
    child: Container(
    padding: const EdgeInsets.only(left :25, top: 10),
    child:Text("Address               : " +
                    employeeModel.address!.street +
                    "," +
                    employeeModel.address!.city,textScaleFactor: 1.2)
    )): Container(),
            employeeModel.company != null
                ?Align(
                alignment: Alignment. topLeft,
                child: Container(
                padding: const EdgeInsets.only(left :25, top: 10),
    child: Text("Company Name : " + employeeModel.company!.name,textScaleFactor: 1.2)
                )) : Container(),
          ]),
        ));
  }
}
