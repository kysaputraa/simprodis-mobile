// To parse this JSON data, do
//
//     final penghargaanModel = penghargaanModelFromMap(jsonString);

import 'dart:convert';

PenghargaanModel penghargaanModelFromMap(String str) =>
    PenghargaanModel.fromMap(json.decode(str));

String penghargaanModelToMap(PenghargaanModel data) =>
    json.encode(data.toMap());

class PenghargaanModel {
  int? code;
  String? message;
  List<Datum>? data;

  PenghargaanModel({this.code, this.message, required this.data});

  factory PenghargaanModel.fromMap(Map<String, dynamic> json) =>
      PenghargaanModel(
        code: json["code"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "code": code,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  String? id;
  String? noPenghargaan;
  String? nik;
  String? namaPenghargaan;
  String? tempat;
  DateTime? tgl;
  dynamic penyelenggara;
  dynamic file;
  String? status;
  String? nama;

  Datum({
    this.id,
    this.noPenghargaan,
    this.nik,
    this.namaPenghargaan,
    this.tempat,
    this.tgl,
    this.penyelenggara,
    this.file,
    this.status,
    this.nama,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    noPenghargaan: json["NoPenghargaan"],
    nik: json["NIK"],
    namaPenghargaan: json["NamaPenghargaan"],
    tempat: json["Tempat"],
    tgl: json["Tgl"] == null ? null : DateTime.parse(json["Tgl"]),
    penyelenggara: json["Penyelenggara"],
    file: json["file"],
    status: json["status"],
    nama: json["Nama"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "NoPenghargaan": noPenghargaan,
    "NIK": nik,
    "NamaPenghargaan": namaPenghargaan,
    "Tempat": tempat,
    "Tgl":
        "${tgl!.year.toString().padLeft(4, '0')}-${tgl!.month.toString().padLeft(2, '0')}-${tgl!.day.toString().padLeft(2, '0')}",
    "Penyelenggara": penyelenggara,
    "file": file,
    "status": status,
    "Nama": nama,
  };
}
