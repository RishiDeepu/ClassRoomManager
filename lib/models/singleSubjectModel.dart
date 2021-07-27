// To parse this JSON data, do
//
//     final singleSubject = singleSubjectFromJson(jsonString);

import 'dart:convert';

SingleSubject singleSubjectFromJson(String str) => SingleSubject.fromJson(json.decode(str));

String singleSubjectToJson(SingleSubject data) => json.encode(data.toJson());

class SingleSubject {
  SingleSubject({
    this.credits,
    this.id,
    this.name,
    this.teacher,
  });

  int credits;
  int id;
  String name;
  String teacher;

  factory SingleSubject.fromJson(Map<String, dynamic> json) => SingleSubject(
    credits: json["credits"],
    id: json["id"],
    name: json["name"],
    teacher: json["teacher"],
  );

  Map<String, dynamic> toJson() => {
    "credits": credits,
    "id": id,
    "name": name,
    "teacher": teacher,
  };
}
