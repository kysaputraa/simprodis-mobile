import 'dart:convert';

ReservoirModel reservoirModelFromJson(String str) =>
    ReservoirModel.fromJson(json.decode(str));

String reservoirModelToJson(ReservoirModel data) => json.encode(data.toJson());

class ReservoirModel {
  int? code;
  String? message;
  List<DataReservoir>? data;

  ReservoirModel({this.code, this.message, this.data});

  factory ReservoirModel.fromJson(Map<String, dynamic> json) => ReservoirModel(
    code: json["code"],
    message: json["message"],
    data:
        json["data"] == null
            ? []
            : List<DataReservoir>.from(
              json["data"]!.map((x) => DataReservoir.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataReservoir {
  String? idReservoir;
  String? namaReservoir;
  String? keterangan;
  String? statusAktif;
  String? idKlpReservoir;

  DataReservoir({
    this.idReservoir,
    this.namaReservoir,
    this.keterangan,
    this.statusAktif,
    this.idKlpReservoir,
  });

  factory DataReservoir.fromJson(Map<String, dynamic> json) => DataReservoir(
    idReservoir: json["id_reservoir"],
    namaReservoir: json["nama_reservoir"],
    keterangan: json["keterangan"],
    statusAktif: json["status_aktif"],
    idKlpReservoir: json["id_klp_reservoir"],
  );

  Map<String, dynamic> toJson() => {
    "id_reservoir": idReservoir,
    "nama_reservoir": namaReservoir,
    "keterangan": keterangan,
    "status_aktif": statusAktif,
    "id_klp_reservoir": idKlpReservoir,
  };
}
