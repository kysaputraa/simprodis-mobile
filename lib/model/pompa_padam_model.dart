import 'dart:convert';

PompaPadamModel pompaPadamModelFromJson(String str) =>
    PompaPadamModel.fromJson(json.decode(str));

String pompaPadamModelToJson(PompaPadamModel data) =>
    json.encode(data.toJson());

class PompaPadamModel {
  int? code;
  String? message;
  DataPompaPadam? data;

  PompaPadamModel({this.code, this.message, this.data});

  factory PompaPadamModel.fromJson(Map<String, dynamic> json) =>
      PompaPadamModel(
        code: json["code"],
        message: json["message"],
        data:
            json["data"] == null ? null : DataPompaPadam.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class DataPompaPadam {
  String? id;
  String? idPompa;
  String? idPetugasHp;
  String? tglPadam;
  String? waktuPadam;
  String? waktuHidupKembali;
  String? durasi;
  String? keterangan;
  String? createdAt;
  String? createBy;
  String? updateAt;
  String? updateBy;
  String? lat;
  String? long;

  DataPompaPadam({
    this.id,
    this.idPompa,
    this.idPetugasHp,
    this.tglPadam,
    this.waktuPadam,
    this.waktuHidupKembali,
    this.durasi,
    this.keterangan,
    this.createdAt,
    this.createBy,
    this.updateAt,
    this.updateBy,
    this.lat,
    this.long,
  });

  factory DataPompaPadam.fromJson(Map<String, dynamic> json) => DataPompaPadam(
    id: json["id"],
    idPompa: json["id_pompa"],
    idPetugasHp: json["id_petugas_hp"],
    tglPadam: json["tgl_padam"],
    waktuPadam: json["waktu_padam"],
    waktuHidupKembali: json["waktu_hidup_kembali"],
    durasi: json["durasi"],
    keterangan: json["keterangan"],
    createdAt: json["createdAt"],
    createBy: json["createBy"],
    updateAt: json["updateAt"],
    updateBy: json["updateBy"],
    lat: json["lat"],
    long: json["long"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_pompa": idPompa,
    "id_petugas_hp": idPetugasHp,
    "tgl_padam": tglPadam,
    "waktu_padam": waktuPadam,
    "waktu_hidup_kembali": waktuHidupKembali,
    "durasi": durasi,
    "keterangan": keterangan,
    "createdAt": createdAt,
    "createBy": createBy,
    "updateAt": updateAt,
    "updateBy": updateBy,
    "lat": lat,
    "long": long,
  };
}
