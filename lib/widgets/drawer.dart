import 'package:flutter/material.dart';
import 'package:screening_test/widgets/registerScreen.dart';
import 'package:screening_test/widgets/showRegisterDataScreen.dart';

class MyDrawer extends Drawer {
  @override
  Widget build(BuildContext context) {
    return Container(width: 300,
      color: Colors.blue.shade50,
      child: Column(children: [
        SizedBox(height: 50,),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
          },
          child: ListTile(
            title: Text("Registration",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
            leading: Icon(Icons.add ,color: Colors.black,),
            dense: true,
          ),
        ),

        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowRegistrationDataScreen()));
          },
          child: ListTile(
            title: Text("Show Registered Data",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,)),
            leading: Icon(Icons.remove_red_eye,color: Colors.black),
            dense: true,
          ),
        ),
      ],),
    );
  }
}