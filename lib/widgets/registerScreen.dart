import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:screening_test/models/registrationModel.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController student = new TextEditingController();
  TextEditingController subject = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Registration"),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: 250,
                height: 50,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Card(
                  elevation: 5,
                  child: TextFormField(
                    controller: student,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Student"),
                    validator: (stu) {
                      if (stu.isEmpty) {
                        return "Student value is empty ";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 250,
                height: 50,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Card(
                  elevation: 5,
                  child: TextFormField(
                    controller: subject,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Subject"),
                    validator: (sub) {
                      if (sub.isEmpty) {
                        return "Subject value is empty ";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  final resp = await http.post(Uri.parse(
                      'https://hamon-interviewapi.herokuapp.com/registration/?api_key=66bD7'),
                  body: {
                    "student":student.text,
                    "subject":subject.text
                  });

                  if(resp.statusCode==200){
                    var respBody= Registration.fromJson(jsonDecode(resp.body));
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.black54,
                            title: Text(
                              "Registration SuccessFul with Registration Id : ${respBody.registration.id}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            actions: [
                              GestureDetector(
                                child: Container(
                                  width: 110,
                                  height: 40,
                                  decoration: BoxDecoration(color: Colors.black54,borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0,left: 10),
                                    child: Text("Ok",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  ),
                                ),
                                onTap: () async {
                                  student.clear();
                                  subject.clear();
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        });

                  }
                },
                child: Container(
                  width: 100,
                  height: 50,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Card(
                      color: Colors.purple,
                      elevation: 5,
                      child: Center(
                          child: Text(
                        "REGISTER",
                        style: TextStyle(color: Colors.white),
                      ))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
