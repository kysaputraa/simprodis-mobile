import 'dart:convert';

PendidikanModel pendidikanModelFromMap(String str) =>
    PendidikanModel.fromMap(json.decode(str));

String pendidikanModelToMap(PendidikanModel data) => json.encode(data.toMap());

class PendidikanModel {
  int? code;
  String? message;
  List<Datum>? data;

  PendidikanModel({this.code, this.message, required this.data});

  factory PendidikanModel.fromMap(Map<String, dynamic> json) => PendidikanModel(
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
  String? nik;
  String? noPendidikan;
  String? kdTingkatDidik;
  String? namaSekolah;
  String? tempatLulus;
  String? tahunLulus;
  String? noIjazah;
  String? file;
  String? keterangan;
  String? status;
  String? tingkatpendidikan;

  Datum({
    this.id,
    this.nik,
    this.noPendidikan,
    this.kdTingkatDidik,
    this.namaSekolah,
    this.tempatLulus,
    this.tahunLulus,
    this.noIjazah,
    this.file,
    this.keterangan,
    this.status,
    this.tingkatpendidikan,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nik: json["NIK"],
    noPendidikan: json["NoPendidikan"],
    kdTingkatDidik: json["KdTingkatDidik"],
    namaSekolah: json["NamaSekolah"],
    tempatLulus: json["TempatLulus"],
    tahunLulus: json["TahunLulus"],
    noIjazah: json["NoIjazah"],
    file: json["file"],
    keterangan: json["Keterangan"],
    status: json["status"],
    tingkatpendidikan: json["tingkatpendidikan"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "NIK": nik,
    "NoPendidikan": noPendidikan,
    "KdTingkatDidik": kdTingkatDidik,
    "NamaSekolah": namaSekolah,
    "TempatLulus": tempatLulus,
    "TahunLulus": tahunLulus,
    "NoIjazah": noIjazah,
    "file": file,
    "Keterangan": keterangan,
    "status": status,
    "tingkatpendidikan": tingkatpendidikan,
  };
}
