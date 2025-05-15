import 'dart:convert';

KelompokPompaModel kelompokPompaModelFromJson(String str) =>
    KelompokPompaModel.fromJson(json.decode(str));

String kelompokPompaModelToJson(KelompokPompaModel data) =>
    json.encode(data.toJson());

class KelompokPompaModel {
  int? code;
  String? message;
  List<DataKelompokPompa>? data;

  KelompokPompaModel({this.code, this.message, this.data});

  factory KelompokPompaModel.fromJson(Map<String, dynamic> json) =>
      KelompokPompaModel(
        code: json["code"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<DataKelompokPompa>.from(
                  json["data"]!.map((x) => DataKelompokPompa.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataKelompokPompa {
  String? idKlpPompa;
  String? namaKlpPompa;
  String? idInstalasi;

  DataKelompokPompa({this.idKlpPompa, this.namaKlpPompa, this.idInstalasi});

  factory DataKelompokPompa.fromJson(Map<String, dynamic> json) =>
      DataKelompokPompa(
        idKlpPompa: json["id_klp_pompa"],
        namaKlpPompa: json["nama_klp_pompa"],
        idInstalasi: json["id_instalasi"],
      );

  Map<String, dynamic> toJson() => {
    "id_klp_pompa": idKlpPompa,
    "nama_klp_pompa": namaKlpPompa,
    "id_instalasi": idInstalasi,
  };
}
