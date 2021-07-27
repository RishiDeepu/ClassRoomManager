// To parse this JSON data, do
//
//     final registration = registrationFromJson(jsonString);

import 'dart:convert';

Registration registrationFromJson(String str) => Registration.fromJson(json.decode(str));

String registrationToJson(Registration data) => json.encode(data.toJson());

class Registration {
  Registration({
    this.registration,
  });

  RegistrationClass registration;

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
    registration: RegistrationClass.fromJson(json["registration"]),
  );

  Map<String, dynamic> toJson() => {
    "registration": registration.toJson(),
  };
}

class RegistrationClass {
  RegistrationClass({
    this.id,
    this.student,
    this.subject,
  });

  int id;
  int student;
  int subject;

  factory RegistrationClass.fromJson(Map<String, dynamic> json) => RegistrationClass(
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
