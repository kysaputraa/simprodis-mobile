// To parse this JSON data, do
//
//     final listrikPadamModel = listrikPadamModelFromJson(jsonString);

import 'dart:convert';

ListrikPadamModel listrikPadamModelFromJson(String str) =>
    ListrikPadamModel.fromJson(json.decode(str));

String listrikPadamModelToJson(ListrikPadamModel data) =>
    json.encode(data.toJson());

class ListrikPadamModel {
  int? code;
  String? message;
  DataListrikPadam? data;

  ListrikPadamModel({this.code, this.message, this.data});

  factory ListrikPadamModel.fromJson(
    Map<String, dynamic> json,
  ) => ListrikPadamModel(
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : DataListrikPadam.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class DataListrikPadam {
  String? id;
  DateTime? tglPadam;
  String? idInstalasi;
  DateTime? waktuPadam;
  DateTime? waktuHidupKembali;
  String? idPetugasHp;
  String? keterangan;
  String? durasi;
  String? createdAt;
  String? createBy;
  String? updateAt;
  String? updateBy;
  String? lat;
  String? long;

  DataListrikPadam({
    this.id,
    this.tglPadam,
    this.idInstalasi,
    this.waktuPadam,
    this.waktuHidupKembali,
    this.idPetugasHp,
    this.keterangan,
    this.durasi,
    this.createdAt,
    this.createBy,
    this.updateAt,
    this.updateBy,
    this.lat,
    this.long,
  });

  factory DataListrikPadam.fromJson(Map<String, dynamic> json) =>
      DataListrikPadam(
        id: json["id"],
        tglPadam:
            json["tgl_padam"] == null
                ? null
                : DateTime.parse(json["tgl_padam"]),
        idInstalasi: json["id_instalasi"],
        waktuPadam:
            json["waktu_padam"] == null
                ? null
                : DateTime.parse(json["waktu_padam"]),
        waktuHidupKembali: json["waktu_hidup_kembali"],
        idPetugasHp: json["id_petugas_hp"],
        keterangan: json["keterangan"],
        durasi: json["durasi"],
        createdAt: json["createdAt"],
        createBy: json["createBy"],
        updateAt: json["updateAt"],
        updateBy: json["updateBy"],
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tgl_padam":
        "${tglPadam!.year.toString().padLeft(4, '0')}-${tglPadam!.month.toString().padLeft(2, '0')}-${tglPadam!.day.toString().padLeft(2, '0')}",
    "id_instalasi": idInstalasi,
    "waktu_padam": waktuPadam?.toIso8601String(),
    "waktu_hidup_kembali": waktuHidupKembali,
    "id_petugas_hp": idPetugasHp,
    "keterangan": keterangan,
    "durasi": durasi,
    "createdAt": createdAt,
    "createBy": createBy,
    "updateAt": updateAt,
    "updateBy": updateBy,
    "lat": lat,
    "long": long,
  };
}
