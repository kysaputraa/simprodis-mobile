import 'dart:convert';

PompaModel pompaModelFromJson(String str) =>
    PompaModel.fromJson(json.decode(str));

String pompaModelToJson(PompaModel data) => json.encode(data.toJson());

class PompaModel {
  int code;
  String message;
  List<DataPompa> data;

  PompaModel({required this.code, required this.message, required this.data});

  factory PompaModel.fromJson(Map<String, dynamic> json) => PompaModel(
    code: json["code"],
    message: json["message"],
    data: List<DataPompa>.from(json["data"].map((x) => DataPompa.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataPompa {
  String idPompa;
  String? namaPompa;
  String? idInstalasi;
  String? speksifikasi;
  String? statusAktif;
  String? keterangan;
  String? idKlpPompa;

  DataPompa({
    required this.idPompa,
    required this.namaPompa,
    required this.idInstalasi,
    required this.speksifikasi,
    required this.statusAktif,
    required this.keterangan,
    required this.idKlpPompa,
  });

  factory DataPompa.fromJson(Map<String, dynamic> json) => DataPompa(
    idPompa: json["id_pompa"],
    namaPompa: json["nama_pompa"],
    idInstalasi: json["id_instalasi"],
    speksifikasi: json["speksifikasi"],
    statusAktif: json["status_aktif"],
    keterangan: json["keterangan"],
    idKlpPompa: json["id_klp_pompa"],
  );

  Map<String, dynamic> toJson() => {
    "id_pompa": idPompa,
    "nama_pompa": namaPompa,
    "id_instalasi": idInstalasi,
    "speksifikasi": speksifikasi,
    "status_aktif": statusAktif,
    "keterangan": keterangan,
    "id_klp_pompa": idKlpPompa,
  };
}
