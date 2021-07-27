import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:screening_test/models/singleClassroomModel.dart';
import 'package:screening_test/widgets/addSubjectToClassScreen.dart';

class IndividualClassroomScreen extends StatefulWidget {
  final int id;
  final String name;

  IndividualClassroomScreen({this.id, this.name});

  @override
  _IndividualClassroomScreenState createState() =>
      _IndividualClassroomScreenState();
}

class _IndividualClassroomScreenState extends State<IndividualClassroomScreen> {
  Future<SingleClassroom> getSingleClassroom() async {
    final resp = await http.get(Uri.parse(
        'https://hamon-interviewapi.herokuapp.com/classrooms/' +
            widget.id.toString() +
            '?api_key=66bD7'));
    if (resp.statusCode == 200) {
      print("ok");
      var functionData= SingleClassroom.fromJson(jsonDecode(resp.body));
      print("functionData : $functionData");
      return functionData;
    }
    else{
      print("Status NotOk");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body:FutureBuilder(
        future: getSingleClassroom(),
        builder: (context, snapShot) {
          print('Data : ${snapShot.hasData}');
          print('SnapShotData : ${snapShot.data}');
          if (snapShot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 90, left: 30),
              child: Container(
                width: 300,
                height: 350,
                decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(40)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        snapShot.data.id.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapShot.data.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Layout : ${snapShot.data.layout}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Size : ${snapShot.data.size}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   'Subject : ${snapShot.data.subject.toString()}',
                    //   style:
                    //   TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    // ),
                    SizedBox(
                      height: 100,
                    ),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AssignSubjectToClassScreen(id: snapShot.data.id,)));
                      },
                      child: Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          "Assign a Subject To class",
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          print("error : ${snapShot.error}");
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
