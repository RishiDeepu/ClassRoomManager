import 'package:flutter/material.dart';
import 'package:screening_test/widgets/classRoomsScreen.dart';
import 'package:screening_test/widgets/drawer.dart';
import 'package:screening_test/widgets/studentsScreen.dart';
import 'package:screening_test/widgets/subjectsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _stateKey= new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _stateKey,
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: GestureDetector(onTap: (){
          _stateKey.currentState.openDrawer();
        },child: Icon(Icons.view_headline,)),
        backgroundColor: Colors.purple,
        title: Text("Home"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.teal.shade50,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text("Classroom manager",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentsScreen(
                                name: "Students",
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: Container(
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(color: Colors.purple.shade100,borderRadius: BorderRadius.circular(10)),

                    child: Center(
                        child: Text(
                      "Students",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black54),
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubjectScreen(
                                name: "Subjects",
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(color: Colors.purple.shade100,borderRadius: BorderRadius.circular(10)),

                    child: Center(
                        child: Text(
                          "Subjects",
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black54),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassroomsScreen(
                                name: "Classrooms",
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(color: Colors.purple.shade100,borderRadius: BorderRadius.circular(10)),

                    child: Center(
                        child: Text(
                          "Classrooms",
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black54),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
