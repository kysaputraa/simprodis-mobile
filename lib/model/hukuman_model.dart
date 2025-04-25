import 'dart:convert';

HukumanModel hukumanModelFromMap(String str) =>
    HukumanModel.fromMap(json.decode(str));

String hukumanModelToMap(HukumanModel data) => json.encode(data.toMap());

class HukumanModel {
  int? code;
  String? message;
  List<Datum>? data;

  HukumanModel({this.code, this.message, required this.data});

  factory HukumanModel.fromMap(Map<String, dynamic> json) => HukumanModel(
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
  String? noHukuman;
  String? kdHukuman;
  DateTime? tglMulai;
  DateTime? tglSelesai;
  dynamic file;
  String? status;
  String? namaHukuman;
  String? nama;

  Datum({
    this.id,
    this.nik,
    this.noHukuman,
    this.kdHukuman,
    this.tglMulai,
    this.tglSelesai,
    this.file,
    this.status,
    this.namaHukuman,
    this.nama,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nik: json["NIK"],
    noHukuman: json["NoHukuman"],
    kdHukuman: json["KdHukuman"],
    tglMulai:
        json["TglMulai"] == null ? null : DateTime.parse(json["TglMulai"]),
    tglSelesai:
        json["TglSelesai"] == null ? null : DateTime.parse(json["TglSelesai"]),
    file: json["file"],
    status: json["status"],
    namaHukuman: json["NamaHukuman"],
    nama: json["Nama"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "NIK": nik,
    "NoHukuman": noHukuman,
    "KdHukuman": kdHukuman,
    "TglMulai":
        "${tglMulai!.year.toString().padLeft(4, '0')}-${tglMulai!.month.toString().padLeft(2, '0')}-${tglMulai!.day.toString().padLeft(2, '0')}",
    "TglSelesai":
        "${tglSelesai!.year.toString().padLeft(4, '0')}-${tglSelesai!.month.toString().padLeft(2, '0')}-${tglSelesai!.day.toString().padLeft(2, '0')}",
    "file": file,
    "status": status,
    "NamaHukuman": namaHukuman,
    "Nama": nama,
  };
}
