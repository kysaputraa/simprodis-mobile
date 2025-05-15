// To parse this JSON data, do
//
//     final pelangganModel = pelangganModelFromJson(jsonString);

import 'dart:convert';

PelangganModel pelangganModelFromJson(String str) =>
    PelangganModel.fromJson(json.decode(str));

String pelangganModelToJson(PelangganModel data) => json.encode(data.toJson());

class PelangganModel {
  int? code;
  String? message;
  DataPelanggan? data;

  PelangganModel({this.code, this.message, this.data});

  factory PelangganModel.fromJson(Map<String, dynamic> json) => PelangganModel(
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : DataPelanggan.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class DataPelanggan {
  String? noPam;
  String? nama;
  String? alamat;
  String? lat;
  String? lng;
  String? zona;
  String? gol;
  String? kdCabang;
  String? foto;
  String? kdKelurahan;
  String? kdKecamatan;
  String? kdStatus;

  DataPelanggan({
    this.noPam,
    this.nama,
    this.alamat,
    this.lat,
    this.lng,
    this.gol,
    this.zona,
    this.kdCabang,
    this.kdKelurahan,
    this.kdKecamatan,
    this.kdStatus,
    this.foto,
  });

  factory DataPelanggan.fromJson(Map<String, dynamic> json) => DataPelanggan(
    noPam: json["NoPAM"],
    nama: json["Nama"],
    alamat: json["Alamat"],
    lat: json["lat"],
    lng: json["lng"],
    zona: json["Zona"],
    gol: json["Gol"],
    kdCabang: json["KdCabang"],
    foto: json["Foto"],
    kdKelurahan: json["KdKelurahan"],
    kdKecamatan: json["KdKecamatan"],
    kdStatus: json["KdStatus"],
  );

  Map<String, dynamic> toJson() => {
    "NoPAM": noPam,
    "Nama": nama,
    "Alamat": alamat,
    "lat": lat,
    "lng": lng,
    "Zona": zona,
    "Gol": gol,
    "KdCabang": kdCabang,
    "Foto": foto,
    "KdKelurahan": kdKelurahan,
    "KdKecamatan": kdKecamatan,
    "KdStatus": kdStatus,
  };
}
