import 'dart:convert';

import 'package:easyalquran/model/jadwalmodel.dart';
import 'package:http/http.dart' as http;

const searchlok = 'https://api.myquran.com/v1/sholat/kota/cari/';
const jadwalapi = 'https://api.myquran.com/v1/sholat/jadwal/';
//jadwalapi = 'https://api.myquran.com/v1/sholat/jadwal/idkota/thn/bln/tgl';
// searchlok = 'https://api.myquran.com/v1/sholat/kota/cari/kota';

class Jadwalervice {
  static Future<List<Jadwalmodel>> getjadwal(enpoint) async {
    try {
      final response = await http.get(Uri.parse(jadwalapi + enpoint));
      if (response.statusCode == 200) {
        final List<Jadwalmodel> listData =
            jadwalmodelFromJsonmap(response.body) as List<Jadwalmodel>;
        return listData;
      } else {
        return <Jadwalmodel>[];
      }
    } catch (e) {
      return <Jadwalmodel>[];
    }
  }

  static getjadwalnomodel(enpoint) async {
    try {
      final response = await http.get(Uri.parse(jadwalapi + enpoint));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']['jadwal'];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future getidkota(kota) async {
    try {
      final response = await http.get(Uri.parse(searchlok + kota));
      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        return res['data'][0]['id'];
      } else {
        return 'error';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
