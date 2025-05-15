import 'dart:convert';

CuciFilterModel cuciFilterModelFromJson(String str) =>
    CuciFilterModel.fromJson(json.decode(str));

String cuciFilterModelToJson(CuciFilterModel data) =>
    json.encode(data.toJson());

class CuciFilterModel {
  int? code;
  String? message;
  DataCuciFilter? data;

  CuciFilterModel({this.code, this.message, this.data});

  factory CuciFilterModel.fromJson(Map<String, dynamic> json) =>
      CuciFilterModel(
        code: json["code"],
        message: json["message"],
        data:
            json["data"] == null ? null : DataCuciFilter.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class DataCuciFilter {
  String? idFilter;
  String? idInstalasi;
  String? jumlahFilter;
  String? statusAktif;

  DataCuciFilter({
    this.idFilter,
    this.idInstalasi,
    this.jumlahFilter,
    this.statusAktif,
  });

  factory DataCuciFilter.fromJson(Map<String, dynamic> json) => DataCuciFilter(
    idFilter: json["id_filter"],
    idInstalasi: json["id_instalasi"],
    jumlahFilter: json["jumlah_filter"],
    statusAktif: json["status_aktif"],
  );

  Map<String, dynamic> toJson() => {
    "id_filter": idFilter,
    "id_instalasi": idInstalasi,
    "jumlah_filter": jumlahFilter,
    "status_aktif": statusAktif,
  };
}
