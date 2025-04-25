class PegawaiModel {
  int? code;
  String? message;
  Data? data;

  PegawaiModel({this.code, this.message, this.data});

  PegawaiModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? username;
  String? nIK;
  String? nama;
  String? level;
  String? id_petugas_hp;

  Data({this.username, this.nIK, this.nama, this.level, this.id_petugas_hp});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    nIK = json['NIK'];
    nama = json['nama'];
    level = json['level'];
    id_petugas_hp = json['id_petugas_hp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = username;
    data['NIK'] = nIK;
    data['nama'] = nama;
    data['level'] = level;
    data['id_petugas_hp'] = id_petugas_hp;
    return data;
  }
}
