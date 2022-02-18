import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class Cekkoneksi {
  static Future<String> cekK() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return 'true';
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return 'true';
    } else {
      return '';
    }
  }
}

class Erornokoneksi extends StatelessWidget {
  const Erornokoneksi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/erorkoneksi.gif',
            width: 50,
          ),
          const Text('Oops..! Tidak ada koneksi internet.'),
        ],
      ),
    );
  }
}
