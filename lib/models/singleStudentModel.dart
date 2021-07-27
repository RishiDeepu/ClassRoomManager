// To parse this JSON data, do
//
//     final singleStudent = singleStudentFromJson(jsonString);

import 'dart:convert';

SingleStudent singleStudentFromJson(String str) => SingleStudent.fromJson(json.decode(str));

String singleStudentToJson(SingleStudent data) => json.encode(data.toJson());

class SingleStudent {
  SingleStudent({
    this.age,
    this.email,
    this.id,
    this.name,
  });

  int age;
  String email;
  int id;
  String name;

  factory SingleStudent.fromJson(Map<String, dynamic> json) => SingleStudent(
    age: json["age"],
    email: json["email"],
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "age": age,
    "email": email,
    "id": id,
    "name": name,
  };
}
