class TinggiSungaiModel {
  int? code;
  String? message;
  List<DataTinggiSungai>? data;

  TinggiSungaiModel({this.code, this.message, this.data});

  TinggiSungaiModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataTinggiSungai>[];
      json['data'].forEach((v) {
        data!.add(new DataTinggiSungai.fromJson(v));
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

class DataTinggiSungai {
  String? id;
  String? idInstalasi;
  String? waktuLapor;
  String? jamLapor;
  String? tinggiSungai;
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

  DataTinggiSungai({
    this.id,
    this.idInstalasi,
    this.waktuLapor,
    this.jamLapor,
    this.tinggiSungai,
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

  DataTinggiSungai.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idInstalasi = json['id_instalasi'];
    waktuLapor = json['waktu_lapor'];
    jamLapor = json['jam_lapor'];
    tinggiSungai = json['tinggi_sungai'];
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
    data['tinggi_sungai'] = this.tinggiSungai;
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
