import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:screening_test/models/singleStudentModel.dart';

class IndividualStudentScreen extends StatefulWidget {
  final int id;
  final String name;

  IndividualStudentScreen({this.id, this.name});

  @override
  _IndividualStudentScreenState createState() =>
      _IndividualStudentScreenState();
}

class _IndividualStudentScreenState extends State<IndividualStudentScreen> {
  Future<SingleStudent> getSingleStudent() async {
    final resp = await http.get(Uri.parse(
        'https://hamon-interviewapi.herokuapp.com//students/' +
            widget.id.toString() +
            '?api_key=66bD7'));
    if (resp.statusCode == 200) {
      return SingleStudent.fromJson(jsonDecode(resp.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(widget.name),
      ),
      body: FutureBuilder(
        future: getSingleStudent(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return Center(
              child: Container(
                width: 300,
                height: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.purple.shade50,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Text(
                              snapShot.data.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),

                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Age : ${snapShot.data.age}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18,color: Colors.grey),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Email : ${snapShot.data.email}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15,color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        'Id : ${snapShot.data.id}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                    )
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
