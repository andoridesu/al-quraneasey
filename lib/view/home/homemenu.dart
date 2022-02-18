import 'package:easyalquran/view/catatan/rekapsholat.dart';
import 'package:easyalquran/view/counter/hitungantasbih.dart';
import 'package:easyalquran/view/doa/kumpulandoa.dart';
import 'package:easyalquran/view/histori/history.dart';
import 'package:easyalquran/view/jadwal/jadwalsholat.dart';
import 'package:easyalquran/view/kiblat/kiblat.dart';
import 'package:easyalquran/view/setting/setting.dart';
import 'package:easyalquran/view/surah/listsurah.dart';
import 'package:flutter/material.dart';

class Homemenu extends StatelessWidget {
  const Homemenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width / 4;
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Componenbutonmenu(widthScreen, 'Jadwal'),
              Componenbutonmenu(widthScreen, 'Qibla'),
              Componenbutonmenu(widthScreen, 'Al-quran'),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Componenbutonmenu(widthScreen, 'Doa-Doa'),
              Componenbutonmenu(widthScreen, 'Hitung Tasbih'),
              Componenbutonmenu(widthScreen, 'Bookmark'),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Componenbutonmenu(widthScreen, 'Rekap Harian'),
              //Componenbutonmenu(widthScreen, 'Bookmark'),
              Componenbutonmenu(widthScreen, 'Pengaturan'),
            ],
          )
        ],
      ),
    );
  }
}

class Componenbutonmenu extends StatelessWidget {
  final double width;
  final String title;
  const Componenbutonmenu(this.width, this.title, {Key? key}) : super(key: key);

  getimage(prop) {
    if (prop == 'Jadwal') {
      return Image.asset(
        'assets/img/mosque.png',
        width: 100,
      );
    } else if (prop == 'Qibla') {
      return Image.asset(
        'assets/img/qibla.png',
        width: 100,
      );
    } else if (prop == 'Al-quran') {
      return Image.asset(
        'assets/img/quran.png',
        width: 100,
      );
    } else if (prop == 'Doa-Doa') {
      return Image.asset(
        'assets/img/pray.png',
        width: 100,
      );
    } else if (prop == 'Bookmark') {
      return Image.asset(
        'assets/img/bookmark.png',
        width: 100,
      );
    } else if (prop == 'Hitung Tasbih') {
      return Image.asset(
        'assets/img/muslim.png',
        width: 100,
      );
    } else if (prop == 'Rekap Harian') {
      return Image.asset(
        'assets/img/list.png',
        width: 100,
      );
    } else if (prop == 'Pengaturan') {
      return Image.asset(
        'assets/img/settings.png',
        width: 100,
      );
    } else {
      return Image.asset(
        'assets/img/malam.png',
        width: 100,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: width,
      child: InkWell(
        child: Column(
          children: [
            Container(
              width: 100,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.grey[400],
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: getimage(title),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Center(
                child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            )),
          ],
        ),
        onTap: () {
          movepage(title, context);
        },
      ),
    );
  }

  void movepage(prop, context) {
    if (prop == 'Pray') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Jadwalsholat()),
      );
    } else if (prop == 'Qibla') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Kiblatviewcompas()));
    } else if (prop == 'Al-quran') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Listsurah()),
      );
    } else if (prop == 'Doa-Doa') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Kumpulandoa()),
      );
    } else if (prop == 'Bookmark') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Historibaca()),
      );
    } else if (prop == 'Hitung Tasbih') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Hitungantasbih()),
      );
    } else if (prop == 'Rekap Harian') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Rekapsholat()),
      );
    } else if (prop == 'Pengaturan') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Setting()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Jadwalsholat()),
      );
    }
  }
}
