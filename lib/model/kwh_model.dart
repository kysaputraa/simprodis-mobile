// To parse this JSON data, do
//
//     final kwhModel = kwhModelFromJson(jsonString);

import 'dart:convert';

KwhModel kwhModelFromJson(String str) => KwhModel.fromJson(json.decode(str));

String kwhModelToJson(KwhModel data) => json.encode(data.toJson());

class KwhModel {
  int? code;
  String? message;
  List<DataKWH>? data;

  KwhModel({this.code, this.message, this.data});

  factory KwhModel.fromJson(Map<String, dynamic> json) => KwhModel(
    code: json["code"],
    message: json["message"],
    data:
        json["data"] == null
            ? []
            : List<DataKWH>.from(json["data"]!.map((x) => DataKWH.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataKWH {
  String? id;
  String? idInstalasi;
  DateTime? waktuLapor;
  String? lwbp;
  String? wbp;
  String? kvarh;
  DateTime? createdAt;
  String? createdBy;
  dynamic updateAt;
  dynamic updateBy;
  String? lat;
  String? long;
  String? idPetugasHp;
  String? nama;
  String? username;
  String? nik;

  DataKWH({
    this.id,
    this.idInstalasi,
    this.waktuLapor,
    this.lwbp,
    this.wbp,
    this.kvarh,
    this.createdAt,
    this.createdBy,
    this.updateAt,
    this.updateBy,
    this.lat,
    this.long,
    this.idPetugasHp,
    this.nama,
    this.username,
    this.nik,
  });

  factory DataKWH.fromJson(Map<String, dynamic> json) => DataKWH(
    id: json["id"],
    idInstalasi: json["id_instalasi"],
    waktuLapor:
        json["waktu_lapor"] == null
            ? null
            : DateTime.parse(json["waktu_lapor"]),
    lwbp: json["lwbp"],
    wbp: json["wbp"],
    kvarh: json["kvarh"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    createdBy: json["createdBy"],
    updateAt: json["updateAt"],
    updateBy: json["updateBy"],
    lat: json["lat"],
    long: json["long"],
    idPetugasHp: json["id_petugas_hp"],
    nama: json["nama"],
    username: json["username"],
    nik: json["NIK"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_instalasi": idInstalasi,
    "waktu_lapor": waktuLapor?.toIso8601String(),
    "lwbp": lwbp,
    "wbp": wbp,
    "kvarh": kvarh,
    "createdAt": createdAt?.toIso8601String(),
    "createdBy": createdBy,
    "updateAt": updateAt,
    "updateBy": updateBy,
    "lat": lat,
    "long": long,
    "id_petugas_hp": idPetugasHp,
    "nama": nama,
    "username": username,
    "NIK": nik,
  };
}
