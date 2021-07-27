// To parse this JSON data, do
//
//     final addSubject = addSubjectFromJson(jsonString);

import 'dart:convert';

AddSubject addSubjectFromJson(String str) => AddSubject.fromJson(json.decode(str));

String addSubjectToJson(AddSubject data) => json.encode(data.toJson());

class AddSubject {
  AddSubject({
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
  int subject;

  factory AddSubject.fromJson(Map<String, dynamic> json) => AddSubject(
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
