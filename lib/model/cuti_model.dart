import 'dart:convert';

CutiModel cutiModelFromMap(String str) => CutiModel.fromMap(json.decode(str));

String cutiModelToMap(CutiModel data) => json.encode(data.toMap());

class CutiModel {
  int? code;
  String? message;
  List<Datum>? data;

  CutiModel({
    this.code,
    this.message,
    this.data,
  });

  factory CutiModel.fromMap(Map<String, dynamic> json) => CutiModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  String? id;
  String? nik;
  String? noCuti;
  String? kdCuti;
  DateTime? tglMulai;
  DateTime? tglSelesai;
  dynamic file;
  String? status;
  String? namaCuti;
  String? nama;

  Datum({
    this.id,
    this.nik,
    this.noCuti,
    this.kdCuti,
    this.tglMulai,
    this.tglSelesai,
    this.file,
    this.status,
    this.namaCuti,
    this.nama,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nik: json["NIK"],
        noCuti: json["NoCuti"],
        kdCuti: json["KdCuti"],
        tglMulai:
            json["TglMulai"] == null ? null : DateTime.parse(json["TglMulai"]),
        tglSelesai: json["TglSelesai"] == null
            ? null
            : DateTime.parse(json["TglSelesai"]),
        file: json["file"],
        status: json["status"],
        namaCuti: json["NamaCuti"],
        nama: json["Nama"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "NIK": nik,
        "NoCuti": noCuti,
        "KdCuti": kdCuti,
        "TglMulai":
            "${tglMulai!.year.toString().padLeft(4, '0')}-${tglMulai!.month.toString().padLeft(2, '0')}-${tglMulai!.day.toString().padLeft(2, '0')}",
        "TglSelesai":
            "${tglSelesai!.year.toString().padLeft(4, '0')}-${tglSelesai!.month.toString().padLeft(2, '0')}-${tglSelesai!.day.toString().padLeft(2, '0')}",
        "file": file,
        "status": status,
        "NamaCuti": namaCuti,
        "Nama": nama,
      };
}
