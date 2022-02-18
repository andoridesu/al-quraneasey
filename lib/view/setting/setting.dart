import 'package:easyalquran/config/adshelper.dart';
import 'package:easyalquran/config/constfunctionglobal.dart';
import 'package:easyalquran/config/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  BannerAd? adBaners;

  Future<void> deleteBookmarkall() async {
    var title = 'Hapus Semua Bookmark';
    var cntn =
        'Anda yakin ingin menghapus data?\nData yang di hapus tidak bisa di pulihkan kembali!';
    dialogdelBookmark(context, title, cntn).then((value) async {
      if (value == 'ok') {
        await Dbhistori.delallHistori();
        snackBarscus(context, 'Berhasil di hapus!');
      }
    });
  }

  Future<void> deleteRekapall() async {
    var title = 'Hapus Rekap Sholat';
    var cntn =
        'Anda yakin ingin menghapus data?\nData yang di hapus tidak bisa di pulihkan kembali!';
    dialogdelBookmark(context, title, cntn).then((value) async {
      if (value == 'ok') {
        await Dbhistori.delallrecap();
        snackBarscus(context, 'Berhasil di hapus!');
      }
    });
  }

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 5),
        physics: const ScrollPhysics(),
        children: <Widget>[
          ListTile(
            leading: const Icon(
              Icons.android,
              size: 30,
            ),
            title: const Text(
              "Tentang Kami",
            ),
            subtitle: const Text("Tentang aplikasi My Al-quran"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.delete_forever,
              size: 30,
            ),
            title: const Text(
              "Hapus Cache Bookmark",
            ),
            subtitle: const Text("Menghapus semua data Bookmark"),
            onTap: () {
              deleteBookmarkall();
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.delete_forever,
              size: 30,
            ),
            title: const Text(
              "Hapus Cache Rekap",
            ),
            subtitle: const Text("Menghapus semua data rekap"),
            onTap: () {
              deleteRekapall();
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.share_outlined,
              size: 30,
            ),
            title: const Text(
              "Share Aplikasi",
            ),
            subtitle: const Text(
              "Membagigan aplikasi",
            ),
            onTap: () {},
          ),
        ],
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
