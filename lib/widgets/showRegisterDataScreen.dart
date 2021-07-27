import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:screening_test/models/deleteRegistration.dart';
import 'package:screening_test/models/showRegisterDataModel.dart';

class ShowRegistrationDataScreen extends StatefulWidget {
  @override
  _ShowRegistrationDataScreenState createState() =>
      _ShowRegistrationDataScreenState();
}

class _ShowRegistrationDataScreenState
    extends State<ShowRegistrationDataScreen> {
  Future<ShowRegistration> getData() async {
    final resp = await http.get(Uri.parse(
        'https://hamon-interviewapi.herokuapp.com/registration/?api_key=66bD7'));
    if (resp.statusCode == 200) {
      print("status ok");
      return ShowRegistration.fromJson(jsonDecode(resp.body));
    } else {
      print("status not ok");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Registered Data"),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            List<Registration> regData = snapShot.data.registrations;
            return ListView.builder(
                itemCount: regData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.teal.shade50,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Id : ${regData[index].id}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 135),
                                child: Text('Subject : ${regData[index].subject}',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold, fontSize: 18)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 80),
                                child: GestureDetector(
                                  onTap: (){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                          backgroundColor: Colors.black54,
                                          title: Text(
                                            "Delete This Data?",
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
                                                child: Center(child: Text("CANCEL",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
                                              ),
                                              onTap: (){
                                                Navigator.pop(context);
                                              },
                                            ),
                                            SizedBox(width: 20,),
                                            GestureDetector(
                                              child: Container(
                                                width: 110,
                                                height: 40,
                                                decoration: BoxDecoration(color: Colors.black54,borderRadius: BorderRadius.circular(10)),
                                                child: Center(child: Text("DELETE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
                                              ),
                                              onTap: ()async{
                                                final resp= await http.delete(Uri.parse('https://hamon-interviewapi.herokuapp.com/registration/'+regData[index].id.toString()+'?api_key=66bD7'));
                                                if(resp.statusCode==200){
                                                  var respBody= Delete.fromJson(jsonDecode(resp.body));
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context){
                                                      return AlertDialog(
                                                        title: Text(respBody.message),
                                                        actions: [
                                                          GestureDetector(
                                                            child: Container(
                                                              width: 110,
                                                              height: 40,
                                                              decoration: BoxDecoration(color: Colors.black54,borderRadius: BorderRadius.circular(10)),
                                                              child: Center(child: Text("OK",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                                              ),
                                                            ),onTap: (){
                                                            setState(() {});
                                                            Navigator.pop(context);
                                                          },
                                                          )
                                                        ],
                                                      );
                                                    }
                                                  );
                                                }
                                              },
                                            )
                                          ],
                                        );
                                      }
                                    );
                                  },
                                    child: Icon(Icons.delete,color: Colors.red,)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Student : ${regData[index].student}',
                              style: TextStyle(
                                color: Colors.grey,
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
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
