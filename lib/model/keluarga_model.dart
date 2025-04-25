// To parse this JSON data, do
//
//     final keluargaModel = keluargaModelFromMap(jsonString);

import 'dart:convert';

KeluargaModel keluargaModelFromMap(String str) =>
    KeluargaModel.fromMap(json.decode(str));

String keluargaModelToMap(KeluargaModel data) => json.encode(data.toMap());

class KeluargaModel {
  int? code;
  String? message;
  List<Data>? data;

  KeluargaModel({this.code, this.message, required this.data});

  factory KeluargaModel.fromMap(Map<String, dynamic> json) => KeluargaModel(
    code: json["code"],
    message: json["message"],
    data:
        json["data"] == null
            ? []
            : List<Data>.from(json["data"]!.map((x) => Data.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Data {
  String? id;
  String? noIdKepangkatan;
  String? nik;
  String? kdKenaikanPangkat;
  String? kdGolLama;
  String? kdGolBaru;
  String? noSkLama;
  String? noSkBaru;
  String? tglSkLama;
  String? tglSkBaru;
  String? tmtLama;
  String? tmtBaru;
  String? gapokLama;
  String? gapokBaru;
  String? mkgLama;
  String? mkgBaru;
  String? tglKenaikanGajiYad;
  String? tempatBekerja;
  String? keterangan;
  String? idKeluarga;
  String? noKeluarga;
  String? nama;
  String? kdStatusKeluarga;
  String? kdKelamin;
  String? tempatLahir;
  String? tglLahir;
  dynamic tanggalLahir;
  String? kdTingkatDidik;
  String? kdPekerjaan;
  String? anakKe;
  String? noAkte;
  String? dptAskes;
  String? dptAsuransiBerobat;
  String? status;
  String? statuskeluarga;
  String? tingkatPendidikan;

  Data({
    this.id,
    this.noIdKepangkatan,
    this.nik,
    this.kdKenaikanPangkat,
    this.kdGolLama,
    this.kdGolBaru,
    this.noSkLama,
    this.noSkBaru,
    this.tglSkLama,
    this.tglSkBaru,
    this.tmtLama,
    this.tmtBaru,
    this.gapokLama,
    this.gapokBaru,
    this.mkgLama,
    this.mkgBaru,
    this.tglKenaikanGajiYad,
    this.tempatBekerja,
    this.keterangan,
    this.idKeluarga,
    this.noKeluarga,
    this.nama,
    this.kdStatusKeluarga,
    this.kdKelamin,
    this.tempatLahir,
    this.tglLahir,
    this.tanggalLahir,
    this.kdTingkatDidik,
    this.kdPekerjaan,
    this.anakKe,
    this.noAkte,
    this.dptAskes,
    this.dptAsuransiBerobat,
    this.status,
    this.statuskeluarga,
    this.tingkatPendidikan,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    noIdKepangkatan: json["NoIDKepangkatan"],
    nik: json["NIK"],
    kdKenaikanPangkat: json["KdKenaikanPangkat"],
    kdGolLama: json["KdGolLama"],
    kdGolBaru: json["KdGolBaru"],
    noSkLama: json["NoSKLama"],
    noSkBaru: json["NoSKBaru"],
    tglSkLama: json["TglSKLama"],
    tglSkBaru: json["TglSKBaru"],
    tmtLama: json["TMTLama"],
    tmtBaru: json["TMTBaru"],
    gapokLama: json["GapokLama"],
    gapokBaru: json["GapokBaru"],
    mkgLama: json["MKGLama"],
    mkgBaru: json["MKGBaru"],
    tglKenaikanGajiYad: json["TglKenaikanGajiYAD"],
    tempatBekerja: json["TempatBekerja"],
    keterangan: json["Keterangan"],
    idKeluarga: json["id_keluarga"],
    noKeluarga: json["NoKeluarga"],
    nama: json["Nama"],
    kdStatusKeluarga: json["KdStatusKeluarga"],
    kdKelamin: json["KdKelamin"],
    tempatLahir: json["TempatLahir"],
    tglLahir: json["TglLahir"],
    tanggalLahir: json["TanggalLahir"],
    kdTingkatDidik: json["KdTingkatDidik"],
    kdPekerjaan: json["KdPekerjaan"],
    anakKe: json["AnakKe"],
    noAkte: json["NoAkte"],
    dptAskes: json["DptAskes"],
    dptAsuransiBerobat: json["DptAsuransiBerobat"],
    status: json["status"],
    statuskeluarga: json["statuskeluarga"],
    tingkatPendidikan: json["TingkatPendidikan"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "NoIDKepangkatan": noIdKepangkatan,
    "NIK": nik,
    "KdKenaikanPangkat": kdKenaikanPangkat,
    "KdGolLama": kdGolLama,
    "KdGolBaru": kdGolBaru,
    "NoSKLama": noSkLama,
    "NoSKBaru": noSkBaru,
    "TglSKLama": tglSkLama,
    "TglSKBaru": tglSkBaru,
    "TMTLama": tmtLama,
    "TMTBaru": tmtBaru,
    "GapokLama": gapokLama,
    "GapokBaru": gapokBaru,
    "MKGLama": mkgLama,
    "MKGBaru": mkgBaru,
    "TglKenaikanGajiYAD": tglKenaikanGajiYad,
    "TempatBekerja": tempatBekerja,
    "Keterangan": keterangan,
    "id_keluarga": idKeluarga,
    "NoKeluarga": noKeluarga,
    "Nama": nama,
    "KdStatusKeluarga": kdStatusKeluarga,
    "KdKelamin": kdKelamin,
    "TempatLahir": tempatLahir,
    "TglLahir": tglLahir,
    "TanggalLahir": tanggalLahir,
    "KdTingkatDidik": kdTingkatDidik,
    "KdPekerjaan": kdPekerjaan,
    "AnakKe": anakKe,
    "NoAkte": noAkte,
    "DptAskes": dptAskes,
    "DptAsuransiBerobat": dptAsuransiBerobat,
    "status": status,
    "statuskeluarga": statuskeluarga,
    "TingkatPendidikan": tingkatPendidikan,
  };
}
