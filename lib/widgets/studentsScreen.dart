import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:screening_test/models/studentsModel.dart';
import 'package:screening_test/widgets/individualStudentScreen.dart';

class StudentsScreen extends StatefulWidget {
  final String name;

  StudentsScreen({this.name});

  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  Future<Students> getStudents() async {
    final response = await http.get(Uri.parse(
        'https://hamon-interviewapi.herokuapp.com//students/?api_key=66bD7'));

    if (response.statusCode == 200) {
      return Students.fromJson(jsonDecode(response.body));
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
        future: getStudents(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            List<Student> data = snapShot.data.students;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IndividualStudentScreen(
                                    name: data[index].name,
                                    id: data[index].id,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 8.0, right: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        child: Card(
                            color: Colors.teal.shade50,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Id : ${data[index].id}',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,bottom: 4.0),
                                  child: Text('Name : ${data[index].name}',style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,bottom: 4.0),
                                  child: Text('Age : ${data[index].age}',style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,bottom: 4.0),
                                  child: Text('Email : ${data[index].email}',style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                                ),
                              ],
                            )
                            // ListTile(
                            //   title: Text(data[index].name),
                            // ),
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
