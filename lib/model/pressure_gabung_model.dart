import 'dart:convert';

PressureGabunganModel pressureGabunganModelFromJson(String str) =>
    PressureGabunganModel.fromJson(json.decode(str));

String pressureGabunganModelToJson(PressureGabunganModel data) =>
    json.encode(data.toJson());

class PressureGabunganModel {
  int code;
  String message;
  List<DataPressureGabungan> data;

  PressureGabunganModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory PressureGabunganModel.fromJson(Map<String, dynamic> json) =>
      PressureGabunganModel(
        code: json["code"],
        message: json["message"],
        data: List<DataPressureGabungan>.from(
          json["data"].map((x) => DataPressureGabungan.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataPressureGabungan {
  String? idPressGab;
  String? namaPressGab;
  String? statusAktif;
  String? idInstalasi;
  String? idKlpPressGab;
  String? keterangan;

  DataPressureGabungan({
    this.idPressGab,
    this.namaPressGab,
    this.statusAktif,
    this.idInstalasi,
    this.idKlpPressGab,
    this.keterangan,
  });

  factory DataPressureGabungan.fromJson(Map<String, dynamic> json) =>
      DataPressureGabungan(
        idPressGab: json["id_press_gab"],
        namaPressGab: json["nama_press_gab"],
        statusAktif: json["status_aktif"],
        idInstalasi: json["id_instalasi"],
        idKlpPressGab: json["id_klp_press_gab"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
    "id_press_gab": idPressGab,
    "nama_press_gab": namaPressGab,
    "status_aktif": statusAktif,
    "id_instalasi": idInstalasi,
    "id_klp_press_gab": idKlpPressGab,
    "keterangan": keterangan,
  };
}
