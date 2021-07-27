import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:screening_test/models/assignSubject.dart';
import 'package:screening_test/widgets/homeScreen.dart';


class AssignSubjectToClassScreen extends StatefulWidget {
  final int id;
  AssignSubjectToClassScreen({this.id});
  @override
  _AssignSubjectToClassScreenState createState() =>
      _AssignSubjectToClassScreenState();
}

class _AssignSubjectToClassScreenState
    extends State<AssignSubjectToClassScreen> {
  TextEditingController subject = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Assign a Subject To a Class"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 30),
        child: Column(
          children: [
            Container(
              width: 300,
              height: 50,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.purple)),
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
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: ()async{
                var resp= await http.patch(Uri.parse('https://hamon-interviewapi.herokuapp.com/classrooms/'+widget.id.toString()+'?api_key=66bD7'),
                      body: {
                        "subject":subject.text
                      });

                if(resp.statusCode==200){
                  var respData=AddSubject.fromJson(jsonDecode(resp.body));
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.black54,
                          title: Text(
                            "SuccessFully Assign Subject",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          actions: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              decoration: BoxDecoration(color: Colors.black54,borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0,left: 10),
                                child: Center(child: Text("ClassRoom : ${respData.name}  Subject :${respData.subject} ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                              ),
                            ),
                            SizedBox(height: 7.0,),
                            GestureDetector(
                              child: Container(
                                width: 110,
                                height: 40,
                                decoration: BoxDecoration(color: Colors.black54,borderRadius: BorderRadius.circular(10)),
                                child: Center(child: Text("OK",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                              ),
                              ),onTap: (){
                                subject.clear();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                            },
                            )
                          ],
                        );
                      });
                }
              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(color: Colors.purple,borderRadius: BorderRadius.circular(20)),
                child: Center(child: Text("Add",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
