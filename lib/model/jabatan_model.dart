// To parse this JSON data, do
//
//     final jabatanModel = jabatanModelFromMap(jsonString);

import 'dart:convert';

JabatanModel jabatanModelFromMap(String str) =>
    JabatanModel.fromMap(json.decode(str));

String jabatanModelToMap(JabatanModel data) => json.encode(data.toMap());

class JabatanModel {
  int? code;
  String? message;
  List<Datum>? data;

  JabatanModel({this.code, this.message, required this.data});

  factory JabatanModel.fromMap(Map<String, dynamic> json) => JabatanModel(
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
  String? noJabatan;
  String? nik;
  dynamic jabatanLama;
  dynamic jabatanBaru;
  DateTime? tmt;
  String? noSk;
  DateTime? tglSk;
  String? keterangan;
  String? kdJabatanBaru;
  String? kdJabatanBaru2;
  String? file;
  String? namaJabatan2;

  Datum({
    this.id,
    this.noJabatan,
    this.nik,
    this.jabatanLama,
    this.jabatanBaru,
    this.tmt,
    this.noSk,
    this.tglSk,
    this.keterangan,
    this.kdJabatanBaru,
    this.kdJabatanBaru2,
    this.file,
    this.namaJabatan2,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    noJabatan: json["NoJabatan"],
    nik: json["NIK"],
    jabatanLama: json["JabatanLama"],
    jabatanBaru: json["JabatanBaru"],
    tmt: json["TMT"] == null ? null : DateTime.parse(json["TMT"]),
    noSk: json["NoSK"],
    tglSk: json["TglSK"] == null ? null : DateTime.parse(json["TglSK"]),
    keterangan: json["Keterangan"],
    kdJabatanBaru: json["KdJabatanBaru"],
    kdJabatanBaru2: json["KdJabatanBaru2"],
    file: json["file"],
    namaJabatan2: json["NamaJabatan2"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "NoJabatan": noJabatan,
    "NIK": nik,
    "JabatanLama": jabatanLama,
    "JabatanBaru": jabatanBaru,
    "TMT":
        "${tmt!.year.toString().padLeft(4, '0')}-${tmt!.month.toString().padLeft(2, '0')}-${tmt!.day.toString().padLeft(2, '0')}",
    "NoSK": noSk,
    "TglSK":
        "${tglSk!.year.toString().padLeft(4, '0')}-${tglSk!.month.toString().padLeft(2, '0')}-${tglSk!.day.toString().padLeft(2, '0')}",
    "Keterangan": keterangan,
    "KdJabatanBaru": kdJabatanBaru,
    "KdJabatanBaru2": kdJabatanBaru2,
    "file": file,
    "NamaJabatan2": namaJabatan2,
  };
}
