import 'dart:convert';

import 'package:easyalquran/model/detailmodel.dart';
import 'package:easyalquran/service/apiservices.dart';
import 'package:http/http.dart' as http;

class Apidetailsurah {
  static Future<List<Detailmodelsurah>> detaildata(String id) async {
    try {
      final response = await http.get(Uri.parse(surahapi + id));
      if (response.statusCode == 200) {
        final List<Detailmodelsurah> listData =
            detailmodelsurahFromJson(response.body) as List<Detailmodelsurah>;
        return listData;
      } else {
        return <Detailmodelsurah>[];
      }
    } catch (e) {
      return <Detailmodelsurah>[];
    }
  }

  static Future details(String id) async {
    try {
      final response = await http.get(Uri.parse(surahapi + id));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return e;
    }
  }
}
