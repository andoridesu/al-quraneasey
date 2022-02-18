// To parse this JSON data, do
//
//     final detailmodelsurah = detailmodelsurahFromJson(jsonString);

import 'dart:convert';

Detailmodelsurah detailmodelsurahFromJson(String str) =>
    Detailmodelsurah.fromJson(json.decode(str));

String detailmodelsurahToJson(Detailmodelsurah data) =>
    json.encode(data.toJson());

class Detailmodelsurah {
  Detailmodelsurah({
    required this.status,
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audio,
    required this.ayat,
    required this.suratSelanjutnya,
    required this.suratSebelumnya,
  });

  bool status;
  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  String tempatTurun;
  String arti;
  String deskripsi;
  String audio;
  List<Ayat> ayat;
  SuratSelanjutnya suratSelanjutnya;
  bool suratSebelumnya;

  factory Detailmodelsurah.fromJson(Map<String, dynamic> json) =>
      Detailmodelsurah(
        status: json["status"],
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["nama_latin"],
        jumlahAyat: json["jumlah_ayat"],
        tempatTurun: json["tempat_turun"],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audio: json["audio"],
        ayat: List<Ayat>.from(json["ayat"].map((x) => Ayat.fromJson(x))),
        suratSelanjutnya: SuratSelanjutnya.fromJson(json["surat_selanjutnya"]),
        suratSebelumnya: json["surat_sebelumnya"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "nomor": nomor,
        "nama": nama,
        "nama_latin": namaLatin,
        "jumlah_ayat": jumlahAyat,
        "tempat_turun": tempatTurun,
        "arti": arti,
        "deskripsi": deskripsi,
        "audio": audio,
        "ayat": List<dynamic>.from(ayat.map((x) => x.toJson())),
        "surat_selanjutnya": suratSelanjutnya.toJson(),
        "surat_sebelumnya": suratSebelumnya,
      };
}

class Ayat {
  Ayat({
    required this.id,
    required this.surah,
    required this.nomor,
    required this.ar,
    required this.tr,
    required this.idn,
  });

  int id;
  int surah;
  int nomor;
  String ar;
  String tr;
  String idn;

  factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
        id: json["id"],
        surah: json["surah"],
        nomor: json["nomor"],
        ar: json["ar"],
        tr: json["tr"],
        idn: json["idn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "surah": surah,
        "nomor": nomor,
        "ar": ar,
        "tr": tr,
        "idn": idn,
      };
}

class SuratSelanjutnya {
  SuratSelanjutnya({
    required this.id,
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audio,
  });

  int id;
  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  String tempatTurun;
  String arti;
  String deskripsi;
  String audio;

  factory SuratSelanjutnya.fromJson(Map<String, dynamic> json) =>
      SuratSelanjutnya(
        id: json["id"],
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["nama_latin"],
        jumlahAyat: json["jumlah_ayat"],
        tempatTurun: json["tempat_turun"],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audio: json["audio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nomor": nomor,
        "nama": nama,
        "nama_latin": namaLatin,
        "jumlah_ayat": jumlahAyat,
        "tempat_turun": tempatTurun,
        "arti": arti,
        "deskripsi": deskripsi,
        "audio": audio,
      };
}
