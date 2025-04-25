import 'dart:convert';

InstalasiModel instalasiModelFromJson(String str) =>
    InstalasiModel.fromJson(json.decode(str));

String instalasiModelToJson(InstalasiModel data) => json.encode(data.toJson());

class InstalasiModel {
  int code;
  String message;
  List<Datum> data;

  InstalasiModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory InstalasiModel.fromJson(Map<String, dynamic> json) => InstalasiModel(
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String username;
  String namaInstalasi;
  String idInstalasi;

  Datum({
    required this.username,
    required this.namaInstalasi,
    required this.idInstalasi,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    username: json["username"],
    namaInstalasi: json["nama_instalasi"],
    idInstalasi: json["id_instalasi"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "nama_instalasi": namaInstalasi,
    "id_instalasi": idInstalasi,
  };
}
