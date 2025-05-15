import 'dart:convert';

SpeyClarifModel clarifModelFromJson(String str) =>
    SpeyClarifModel.fromJson(json.decode(str));

String clarifModelToJson(SpeyClarifModel data) => json.encode(data.toJson());

class SpeyClarifModel {
  int? code;
  String? message;
  DataClarif? data;

  SpeyClarifModel({this.code, this.message, this.data});

  factory SpeyClarifModel.fromJson(Map<String, dynamic> json) =>
      SpeyClarifModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : DataClarif.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class DataClarif {
  String? idClarif;
  String? idInstalasi;
  String? jumlahClarif;
  String? statusAktif;

  DataClarif({
    this.idClarif,
    this.idInstalasi,
    this.jumlahClarif,
    this.statusAktif,
  });

  factory DataClarif.fromJson(Map<String, dynamic> json) => DataClarif(
    idClarif: json["id_clarif"],
    idInstalasi: json["id_instalasi"],
    jumlahClarif: json["jumlah_clarif"],
    statusAktif: json["status_aktif"],
  );

  Map<String, dynamic> toJson() => {
    "id_clarif": idClarif,
    "id_instalasi": idInstalasi,
    "jumlah_clarif": jumlahClarif,
    "status_aktif": statusAktif,
  };
}
