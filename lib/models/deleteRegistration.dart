// To parse this JSON data, do
//
//     final delete = deleteFromJson(jsonString);

import 'dart:convert';

Delete deleteFromJson(String str) => Delete.fromJson(json.decode(str));

String deleteToJson(Delete data) => json.encode(data.toJson());

class Delete {
  Delete({
    this.message,
  });

  String message;

  factory Delete.fromJson(Map<String, dynamic> json) => Delete(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
