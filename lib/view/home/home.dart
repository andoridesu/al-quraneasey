import 'dart:async';
import 'dart:ui';

import 'package:easyalquran/config/adshelper.dart';
import 'package:easyalquran/config/setchekoneksi.dart';
import 'package:easyalquran/config/setlocalnotif.dart';
import 'package:easyalquran/service/apiservices.dart';
import 'package:easyalquran/view/home/componentwidget.dart';
import 'package:easyalquran/view/home/homemenu.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime now = DateTime.now();
  bool isloading = false;
  bool isRunning = true;
  String day = '';
  String time = '';
  String date = '';
  BannerAd? adBaners;

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Pagi';
    }
    if (hour < 17) {
      return 'Siang';
    }
    if (hour < 19) {
      return 'Sore';
    }
    return 'Malam';
  }

  void _dayTime() {
    setState(() {
      day = DateFormat('EEEE').format(now);
      time = DateFormat("HH:mm:ss").format(now);
      date = DateFormat("yyyy-MM-dd").format(now);
    });
  }

  void _minutedTime() {
    Future.delayed(const Duration(seconds: 1), () {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!isRunning) {
          timer.cancel();
        }
        setState(() {
          time = DateFormat("HH:mm:ss").format(DateTime.now());
        });
      });
    });
  }

  void getcalndarhijri() {
    var dt = DateFormat("dd-MM-yyyy").format(DateTime.now());
    Cekkoneksi.cekK().then((t) {
      if (t.isNotEmpty) {
        Calndrhijri.gethijri(dt).then((hj) {});
      }
    });
  }

  @override
  void initState() {
    Setlocalnotif.init(context);
    getcalndarhijri();
    _dayTime();
    _minutedTime();
    adBaners = BannerAd(
        size: AdSize.banner,
        adUnitId: Adshelper.idads,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            debugPrint('$BannerAd loaded.');
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            debugPrint('$BannerAd failedToLoad: $error');
            ad.dispose();
          },
          onAdOpened: (Ad ad) => debugPrint('$BannerAd onAdOpened.'),
          onAdClosed: (Ad ad) => debugPrint('$BannerAd onAdClosed.'),
        ),
        request: const AdRequest())
      ..load();
    super.initState();
  }

  @override
  void dispose() {
    isRunning = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: dekorbg,
        child: Column(
          children: [
            AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Headercomponent(date, day, time, greeting())),
            const SizedBox(
              height: 30,
            ),
            const Homemenu()
          ],
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          final BannerAd? bannerAd = adBaners;
          return SizedBox(
            height: bannerAd?.size.height.toDouble(),
            width: bannerAd?.size.width.toDouble(),
            child: AdWidget(ad: adBaners!),
          );
        },
      ),
    );
  }
}
