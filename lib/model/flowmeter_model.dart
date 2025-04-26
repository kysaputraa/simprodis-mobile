import 'dart:convert';

FlowmeterModel standMeterModelFromJson(String str) =>
    FlowmeterModel.fromJson(json.decode(str));

String standMeterModelToJson(FlowmeterModel data) => json.encode(data.toJson());

class FlowmeterModel {
  int? code;
  String? message;
  List<DataFlowmeter>? data;

  FlowmeterModel({this.code, this.message, this.data});

  factory FlowmeterModel.fromJson(Map<String, dynamic> json) => FlowmeterModel(
    code: json["code"],
    message: json["message"],
    data:
        json["data"] == null
            ? []
            : List<DataFlowmeter>.from(
              json["data"]!.map((x) => DataFlowmeter.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataFlowmeter {
  String? idFlowmeter;
  String? namaFlowmeter;
  String? idInstalasi;
  dynamic keterangan;
  String? statusAktif;

  DataFlowmeter({
    this.idFlowmeter,
    this.namaFlowmeter,
    this.idInstalasi,
    this.keterangan,
    this.statusAktif,
  });

  factory DataFlowmeter.fromJson(Map<String, dynamic> json) => DataFlowmeter(
    idFlowmeter: json["id_flowmeter"],
    namaFlowmeter: json["nama_flowmeter"],
    idInstalasi: json["id_instalasi"],
    keterangan: json["keterangan"],
    statusAktif: json["status_aktif"],
  );

  Map<String, dynamic> toJson() => {
    "id_flowmeter": idFlowmeter,
    "nama_flowmeter": namaFlowmeter,
    "id_instalasi": idInstalasi,
    "keterangan": keterangan,
    "status_aktif": statusAktif,
  };
}
