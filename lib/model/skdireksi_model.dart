import 'dart:convert';

SkDireksiModel skDireksiModelFromMap(String str) =>
    SkDireksiModel.fromMap(json.decode(str));

String skDireksiModelToMap(SkDireksiModel data) => json.encode(data.toMap());

class SkDireksiModel {
  int? code;
  String? message;
  List<Datum>? data;

  SkDireksiModel({this.code, this.message, required this.data});

  factory SkDireksiModel.fromMap(Map<String, dynamic> json) => SkDireksiModel(
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
  String? nama;
  String? file;
  String? status;
  DateTime? createdAt;

  Datum({this.id, this.nama, this.file, this.status, this.createdAt});

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nama: json["nama"],
    file: json["file"],
    status: json["status"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nama": nama,
    "file": file,
    "status": status,
    "createdAt":
        "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
  };
}
