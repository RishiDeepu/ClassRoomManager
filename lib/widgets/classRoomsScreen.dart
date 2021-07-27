import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:screening_test/models/classroomsModel.dart';
import 'package:screening_test/widgets/individualClassroomScreen.dart';

class ClassroomsScreen extends StatefulWidget {
  final String name;

  ClassroomsScreen({this.name});

  @override
  _ClassroomsScreenState createState() => _ClassroomsScreenState();
}

class _ClassroomsScreenState extends State<ClassroomsScreen> {
  Future<Classrooms> getClassrooms() async {
    final res = await http.get(Uri.parse(
        'https://hamon-interviewapi.herokuapp.com/classrooms/?api_key=66bD7'));

    if (res.statusCode == 200) {
      return Classrooms.fromJson(jsonDecode(res.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: FutureBuilder(
        future: getClassrooms(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            List<Classroom> data = snapShot.data.classrooms;
            return GridView.builder(
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  IndividualClassroomScreen(name: data[index].name,id: data[index].id,)));
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
                                  child: Center(child: Text(data[index].id.toString(),style: TextStyle(color: Colors.white),)),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(data[index].name,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20)),
                              Text('Layout : ${data[index].layout}',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 15)),
                              Text('Size : ${data[index].size}',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 15)),


                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
