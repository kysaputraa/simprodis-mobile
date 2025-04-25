// To parse this JSON dataInstalasi, do
//
//     final IntakeModel = IntakeModelFromMap(jsonString);

import 'dart:convert';

IntakeModel IntakeModelFromMap(String str) =>
    IntakeModel.fromMap(json.decode(str));

String IntakeModelToMap(IntakeModel dataInstalasi) =>
    json.encode(dataInstalasi.toMap());

class IntakeModel {
  int? code;
  String? message;
  String? tanggal;
  String? jam;
  List<Datum>? dataInstalasi;

  IntakeModel({
    this.code,
    this.message,
    required this.dataInstalasi,
    this.tanggal,
    this.jam,
  });

  factory IntakeModel.fromMap(Map<String, dynamic> json) => IntakeModel(
    code: json["code"],
    message: json["message"],
    dataInstalasi:
        json["dataInstalasi"] == null
            ? []
            : List<Datum>.from(
              json["dataInstalasi"]!.map((x) => Datum.fromMap(x)),
            ),
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "message": message,
    "dataInstalasi":
        dataInstalasi == null
            ? []
            : List<dynamic>.from(dataInstalasi!.map((x) => x.toMap())),
  };
}

class Datum {
  String? id;
  String? noIntak;
  String? nik;
  String? namaIntak;
  String? tempat;
  DateTime? tgl;
  dynamic penyelenggara;
  dynamic file;
  String? status;
  String? nama;

  Datum({
    this.id,
    this.noIntak,
    this.nik,
    this.namaIntak,
    this.tempat,
    this.tgl,
    this.penyelenggara,
    this.file,
    this.status,
    this.nama,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    noIntak: json["NoIntak"],
    nik: json["NIK"],
    namaIntak: json["NamaIntak"],
    tempat: json["Tempat"],
    tgl: json["Tgl"] == null ? null : DateTime.parse(json["Tgl"]),
    penyelenggara: json["Penyelenggara"],
    file: json["file"],
    status: json["status"],
    nama: json["Nama"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "NoIntak": noIntak,
    "NIK": nik,
    "NamaIntak": namaIntak,
    "Tempat": tempat,
    "Tgl":
        "${tgl!.year.toString().padLeft(4, '0')}-${tgl!.month.toString().padLeft(2, '0')}-${tgl!.day.toString().padLeft(2, '0')}",
    "Penyelenggara": penyelenggara,
    "file": file,
    "status": status,
    "Nama": nama,
  };
}
