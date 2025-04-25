import 'dart:convert';

StandMeterModel standMeterModelFromJson(String str) =>
    StandMeterModel.fromJson(json.decode(str));

String standMeterModelToJson(StandMeterModel data) =>
    json.encode(data.toJson());

class StandMeterModel {
  int? code;
  String? message;
  List<DataStandMeter>? data;

  StandMeterModel({this.code, this.message, this.data});

  factory StandMeterModel.fromJson(Map<String, dynamic> json) =>
      StandMeterModel(
        code: json["code"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<DataStandMeter>.from(
                  json["data"]!.map((x) => DataStandMeter.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataStandMeter {
  String? idMeter;
  String? idKlpMeter;
  String? namaMeter;
  dynamic idInstalasi;
  String? spesifikasi;
  String? statusAktif;

  DataStandMeter({
    this.idMeter,
    this.idKlpMeter,
    this.namaMeter,
    this.idInstalasi,
    this.spesifikasi,
    this.statusAktif,
  });

  factory DataStandMeter.fromJson(Map<String, dynamic> json) => DataStandMeter(
    idMeter: json["id_meter"],
    idKlpMeter: json["id_klp_meter"],
    namaMeter: json["nama_meter"],
    idInstalasi: json["id_instalasi"],
    spesifikasi: json["spesifikasi"],
    statusAktif: json["status_aktif"],
  );

  Map<String, dynamic> toJson() => {
    "id_meter": idMeter,
    "id_klp_meter": idKlpMeter,
    "nama_meter": namaMeter,
    "id_instalasi": idInstalasi,
    "spesifikasi": spesifikasi,
    "status_aktif": statusAktif,
  };
}
