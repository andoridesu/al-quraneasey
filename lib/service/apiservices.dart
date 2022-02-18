import 'dart:convert';

import 'package:easyalquran/config/shareprefenceseting.dart';
import 'package:easyalquran/model/listmodel.dart';
import 'package:http/http.dart' as http;

// server api
const surahapi = 'https://equran.id/api/surat/';

class Apiservice {
  static Future<List<Modelsurah>> getdata() async {
    try {
      final response = await http.get(Uri.parse(surahapi));
      if (response.statusCode == 200) {
        final List<Modelsurah> listData = modelsurahFromJson(response.body);
        return listData;
      } else {
        return <Modelsurah>[];
      }
    } catch (e) {
      return <Modelsurah>[];
    }
  }
}

class Calndrhijri {
  static String calnhijri = 'https://api.flagodna.com/hijriyah/api/';
// endpoint 05-02-2022
  static Future<String> gethijri(date) async {
    try {
      final response = await http.get(Uri.parse(calnhijri + date));
      if (response.statusCode == 200) {
        final dt = jsonDecode(response.body);
        String hijri = dt[0]['tanggal_hijriyah'] +
            ' ' +
            dt[0]['bulan_hijriyah'] +
            ' ' +
            dt[0]['tahun_hijriyah'] +
            ' H';
        Sharepref.sets('hijri', hijri);
        return hijri;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }
}
