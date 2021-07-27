// To parse this JSON data, do
//
//     final showRegistration = showRegistrationFromJson(jsonString);

import 'dart:convert';

ShowRegistration showRegistrationFromJson(String str) => ShowRegistration.fromJson(json.decode(str));

String showRegistrationToJson(ShowRegistration data) => json.encode(data.toJson());

class ShowRegistration {
  ShowRegistration({
    this.registrations,
  });

  List<Registration> registrations;

  factory ShowRegistration.fromJson(Map<String, dynamic> json) => ShowRegistration(
    registrations: List<Registration>.from(json["registrations"].map((x) => Registration.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "registrations": List<dynamic>.from(registrations.map((x) => x.toJson())),
  };
}

class Registration {
  Registration({
    this.id,
    this.student,
    this.subject,
  });

  int id;
  int student;
  int subject;

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
    id: json["id"],
    student: json["student"],
    subject: json["subject"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student": student,
    "subject": subject,
  };
}
