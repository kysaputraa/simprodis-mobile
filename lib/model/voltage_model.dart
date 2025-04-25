class VoltageModel {
  int? code;
  String? message;
  List<DataVoltage>? data;

  VoltageModel({this.code, this.message, this.data});

  VoltageModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataVoltage>[];
      json['data'].forEach((v) {
        data!.add(new DataVoltage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataVoltage {
  String? id;
  String? idInstalasi;
  String? waktuLapor;
  String? jamLapor;
  String? voltRn;
  String? voltRs;
  String? voltSt;
  String? voltRt;
  String? createdAt;
  String? createdBy;
  String? updateAt;
  String? updateBy;
  String? lat;
  String? long;
  String? idPetugasHp;
  String? nama;
  String? username;
  String? nIK;
  String? namaInstalasi;

  DataVoltage({
    this.id,
    this.idInstalasi,
    this.waktuLapor,
    this.jamLapor,
    this.voltRn,
    this.voltRs,
    this.voltSt,
    this.voltRt,
    this.createdAt,
    this.createdBy,
    this.updateAt,
    this.updateBy,
    this.lat,
    this.long,
    this.idPetugasHp,
    this.nama,
    this.username,
    this.nIK,
    this.namaInstalasi,
  });

  DataVoltage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idInstalasi = json['id_instalasi'];
    waktuLapor = json['waktu_lapor'];
    jamLapor = json['jam_lapor'];
    voltRn = json['volt_rn'];
    voltRs = json['volt_rs'];
    voltSt = json['volt_st'];
    voltRt = json['volt_rt'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updateAt = json['updateAt'];
    updateBy = json['updateBy'];
    lat = json['lat'];
    long = json['long'];
    idPetugasHp = json['id_petugas_hp'];
    nama = json['nama'];
    username = json['username'];
    nIK = json['NIK'];
    namaInstalasi = json['nama_instalasi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_instalasi'] = this.idInstalasi;
    data['waktu_lapor'] = this.waktuLapor;
    data['jam_lapor'] = this.jamLapor;
    data['volt_rn'] = this.voltRn;
    data['volt_rs'] = this.voltRs;
    data['volt_st'] = this.voltSt;
    data['volt_rt'] = this.voltRt;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['updateAt'] = this.updateAt;
    data['updateBy'] = this.updateBy;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['id_petugas_hp'] = this.idPetugasHp;
    data['nama'] = this.nama;
    data['username'] = this.username;
    data['NIK'] = this.nIK;
    data['nama_instalasi'] = this.namaInstalasi;
    return data;
  }
}
