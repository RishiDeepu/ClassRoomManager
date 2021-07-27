// To parse this JSON data, do
//
//     final singleClassroom = singleClassroomFromJson(jsonString);

import 'dart:convert';

SingleClassroom singleClassroomFromJson(String str) => SingleClassroom.fromJson(json.decode(str));

String singleClassroomToJson(SingleClassroom data) => json.encode(data.toJson());

class SingleClassroom {
  SingleClassroom({
    this.id,
    this.layout,
    this.name,
    this.size,
    this.subject,
  });

  int id;
  String layout;
  String name;
  int size;
  String subject;

  factory SingleClassroom.fromJson(Map<String, dynamic> json) => SingleClassroom(
    id: json["id"],
    layout: json["layout"],
    name: json["name"],
    size: json["size"],
    subject: json["subject"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "layout": layout,
    "name": name,
    "size": size,
    "subject": subject,
  };
}


