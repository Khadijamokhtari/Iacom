import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromMap(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  String id;
  String Name;
  String Email;
  String Mobile;
  String Password;

  User({
    this.id,
    this.Name,
    this.Email,
    this.Mobile,
    this.Password,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    Name: json["Name"],
    Email: json["Email"],
    Mobile: json["Mobile"],
    Password: json["Password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Name": Name,
    "Email": Email,
    "Mobile": Mobile,
    "Password": Password,
  };
}