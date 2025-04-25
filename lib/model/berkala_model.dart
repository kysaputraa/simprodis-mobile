import 'dart:convert';

BerkalaModel berkalaFromMap(String str) =>
    BerkalaModel.fromMap(json.decode(str));

String berkalaToMap(BerkalaModel data) => json.encode(data.toMap());

class BerkalaModel {
  int? code;
  String? message;
  List<Datum>? data;

  BerkalaModel({this.code, this.message, required this.data});

  factory BerkalaModel.fromMap(Map<String, dynamic> json) => BerkalaModel(
    code: json["code"],
    message: json["message"],
    data:
        json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
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
  String? kenaikanPangkat;
  String? file;

  Datum({
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
    this.kenaikanPangkat,
    this.file,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
    kenaikanPangkat: json["KenaikanPangkat"],
    file: json["file"],
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
    "KenaikanPangkat": kenaikanPangkat,
    "file": file,
  };
}
