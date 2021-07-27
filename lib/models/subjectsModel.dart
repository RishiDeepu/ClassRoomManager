// To parse this JSON data, do
//
//     final subjects = subjectsFromJson(jsonString);

import 'dart:convert';

Subjects subjectsFromJson(String str) => Subjects.fromJson(json.decode(str));

String subjectsToJson(Subjects data) => json.encode(data.toJson());

class Subjects {
  Subjects({
    this.subjects,
  });

  List<Subject> subjects;

  factory Subjects.fromJson(Map<String, dynamic> json) => Subjects(
    subjects: List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
  };
}

class Subject {
  Subject({
    this.credits,
    this.id,
    this.name,
    this.teacher,
  });

  int credits;
  int id;
  String name;
  String teacher;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
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
