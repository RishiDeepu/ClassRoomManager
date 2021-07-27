import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:screening_test/models/singleSubjectModel.dart';

class IndividualSubjectScreen extends StatefulWidget {

  final int id;
  final String name;

  IndividualSubjectScreen({this.id, this.name});
  @override
  _IndividualSubjectScreenState createState() => _IndividualSubjectScreenState();
}

class _IndividualSubjectScreenState extends State<IndividualSubjectScreen> {
  Future<SingleSubject> getSingleSubject() async {
    final resp = await http.get(Uri.parse(
        'https://hamon-interviewapi.herokuapp.com/subjects/'+widget.id.toString()+'?api_key=66bD7'));
    if(resp.statusCode==200){
      return SingleSubject.fromJson(jsonDecode(resp.body));
    }
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(widget.name),
      ),
      body:FutureBuilder(
        future: getSingleSubject(),
        builder: (context,snapShot){
          if(snapShot.hasData){
            return Center(
              child: Container(
                width: 300,
                height: 150,
                decoration: BoxDecoration(color: Colors.purple.shade50,borderRadius: BorderRadius.circular(40)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(snapShot.data.id.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    Text(snapShot.data.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text('Credits : ${snapShot.data.credits}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text('Teacher : ${snapShot.data.teacher}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
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
