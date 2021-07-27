import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:screening_test/models/subjectsModel.dart';
import 'package:screening_test/widgets/individualSubjectScreen.dart';

class SubjectScreen extends StatefulWidget {
  final String name;

  SubjectScreen({this.name});

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  Future<Subjects> getSubjects() async {
    final resp = await http.get(Uri.parse(
        'https://hamon-interviewapi.herokuapp.com/subjects/?api_key=66bD7'));
    if (resp.statusCode == 200) {
      return Subjects.fromJson(jsonDecode(resp.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(widget.name),
      ),
      body: FutureBuilder(
        future: getSubjects(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            List<Subject> subjectData=snapShot.data.subjects;
            return
              GridView.builder(
              itemCount: subjectData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // crossAxisSpacing: 5.0,
                    // mainAxisSpacing: 5.0
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>IndividualSubjectScreen(
                        name: subjectData[index].name,
                        id: subjectData[index].id,
                      )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 150,
                        height: 120,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.pink),
                            borderRadius: BorderRadius.circular(10)),
                        child: Card(
                          color: Colors.teal.shade50,
                          elevation: 6,
                          child:Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(color: Colors.purple,borderRadius: BorderRadius.circular(25)),
                                  child: Center(child: Text(subjectData[index].id.toString(),style: TextStyle(color: Colors.white),)),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(subjectData[index].name,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20)),
                              Text('Credits : ${subjectData[index].credits}',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 15)),
                              Text('Teacher : ${subjectData[index].teacher}',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 15)),


                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
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
