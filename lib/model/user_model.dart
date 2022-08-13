// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

part of 'models.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.fullName,
    required this.username,
    required this.divisi,
    this.subdivisi,
    required this.joblevel,
  });

  int id;
  String fullName;
  String username;
  Divisi divisi;
  SubDivisi? subdivisi;
  Divisi joblevel;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullName: json["full_name"],
        username: json["username"],
        divisi: Divisi.fromJson(json["divisi"]),
        subdivisi: json["subdivisi"] == null
            ? null
            : SubDivisi.fromJson(json["subdivisi"]),
        joblevel: Divisi.fromJson(json["joblevel"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "username": username,
        "divisi": divisi.toJson(),
        "subdivisi": subdivisi,
        "joblevel": joblevel.toJson(),
      };
}

class Divisi {
  Divisi({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Divisi.fromJson(Map<String, dynamic> json) => Divisi(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class SubDivisi {
  SubDivisi({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory SubDivisi.fromJson(Map<String, dynamic> json) => SubDivisi(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
