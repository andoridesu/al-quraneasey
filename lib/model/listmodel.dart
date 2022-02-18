// To parse this JSON data, do
//
//     final modelsurah = modelsurahFromJson(jsonString);

import 'dart:convert';

List<Modelsurah> modelsurahFromJson(String str) =>
    List<Modelsurah>.from(json.decode(str).map((x) => Modelsurah.fromJson(x)));

String modelsurahToJson(List<Modelsurah> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Modelsurah {
  Modelsurah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audio,
  });

  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  String tempatTurun;
  String arti;
  String deskripsi;
  String audio;

  factory Modelsurah.fromJson(Map<String, dynamic> json) => Modelsurah(
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
