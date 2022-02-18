import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:easyalquran/config/loadingcomponent.dart';
import 'package:easyalquran/config/setchekoneksi.dart';
import 'package:easyalquran/model/listmodel.dart';
import 'package:easyalquran/service/apiservices.dart';
import 'package:easyalquran/view/details/detailsurah.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Listsurah extends StatefulWidget {
  const Listsurah({Key? key}) : super(key: key);

  @override
  _ListsurahState createState() => _ListsurahState();
}

class _ListsurahState extends State<Listsurah> {
  bool isloading = true;
  bool isSearch = false;
  String filter = '';
  String koneksi = '';
  TextEditingController controller = TextEditingController();
  AudioPlayer audioPlayer = AudioPlayer();
  Widget appBarTitle = const Text("Baca Al-Qur'an");
  Icon actionIcon = const Icon(Icons.search);
  List<Modelsurah> surah = [];
  List<Modelsurah> filteredList = [];
  List<bool> isplay = [];

  void getdata() {
    Apiservice.getdata().then((value) {
      if (value.isNotEmpty) {
        setState(() {
          surah = value;
          isplay = List<bool>.filled(value.length, false);
          isloading = false;
        });
      }
    });
  }

  void playaudio(url, i) async {
    setState(() {
      isplay[i] = !isplay[i];
    });
    if (!isplay[i]) {
      await audioPlayer.stop();
    } else {
      await audioPlayer.play(url);
      audioPlayer.onPlayerCompletion.listen((event) {
        setState(() {
          isplay[i] = !isplay[i];
        });
      });
    }
  }

  Future<void> onrefresh() async {
    setState(() {
      isloading = true;
      surah = [];
      isplay = [];
    });
    getdata();
  }

  setSercbox() {
    controller.addListener(() {
      if (controller.text.isEmpty) {
        setState(() {
          isSearch = false;
          filter = "";
          filteredList = surah;
        });
      } else {
        setState(() {
          isSearch = true;
          filter = controller.text;
        });
        if ((filter.isNotEmpty)) {
          List<Modelsurah> tmpList = [];
          for (int i = 0; i < filteredList.length; i++) {
            if (filteredList[i]
                .namaLatin
                .toLowerCase()
                .contains(filter.toLowerCase())) {
              tmpList.add(filteredList[i]);
            }
          }
          filteredList = tmpList;
        }
      }
    });
  }

  void cekKoneksi() {
    Cekkoneksi.cekK().then((val) {
      setState(() {
        koneksi = val;
      });
      if (val.isNotEmpty) {
        getdata();
      }
      if (val.isEmpty) {
        setState(() => isloading = false);
      }
    });
  }

  runTimer() {
    if (koneksi.isEmpty) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (koneksi.isNotEmpty) {
          timer.cancel();
          // setState(() => isloading = true);
        }
        cekKoneksi();
      });
    }
  }

  @override
  void initState() {
    runTimer();
    // cekKoneksi();
    setSercbox();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final apPbar = AppBar(
      title: appBarTitle,
      actions: [
        IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (actionIcon.icon == Icons.search) {
                  actionIcon = const Icon(Icons.close);
                  appBarTitle = TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    autofocus: true,
                    cursorColor: Colors.white,
                  );
                } else {
                  actionIcon = const Icon(Icons.search);
                  appBarTitle = const Text("Baca Al-Qur'an");
                  filteredList = surah;
                  controller.clear();
                }
              });
            })
      ],
    );

    return Scaffold(
      appBar: apPbar,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: isloading
            ? const Isloading()
            : koneksi.isEmpty
                ? const Erornokoneksi()
                : RefreshIndicator(
                    onRefresh: () => onrefresh(),
                    child: ListView.separated(
                      itemCount: isSearch ? filteredList.length : surah.length,
                      itemBuilder: (context, int i) {
                        Modelsurah sur = isSearch ? filteredList[i] : surah[i];
                        return _builddata(sur, i);
                      },
                      separatorBuilder: (context, i) {
                        return const Divider(
                          height: 1,
                        );
                      },
                    ),
                  ),
      ),
    );
  }

  Widget _builddata(Modelsurah sur, i) {
    var namaSurah = sur.namaLatin;
    var jmlhayat = sur.tempatTurun.toUpperCase() +
        ' | ' +
        sur.jumlahAyat.toString() +
        ' Ayat';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Detailsurah(sur.nomor.toString())),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            buildLeft(sur.nomor.toString()),
            buildMid(namaSurah, sur.nama, jmlhayat),
            buildRight(sur.audio, i),
          ],
        ),
      ),
    );
  }

  Widget buildLeft(nomor) {
    return Container(
      width: MediaQuery.of(context).size.width / 9,
      height: MediaQuery.of(context).size.width / 9,
      margin: const EdgeInsets.only(right: 12, left: 6),
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage("assets/img/icnomor.png")),
      ),
      child: Center(
        child: Text(
          nomor,
          style: const TextStyle(
              fontSize: 11, fontWeight: FontWeight.w500, color: Colors.green),
        ),
      ),
    );
  }

  Widget buildMid(namaSurah, namaarb, jmlhayat) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  namaSurah,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  jmlhayat,
                  style: TextStyle(fontSize: 13, color: Colors.brown[700]),
                )
              ],
            ),
          ),
          Expanded(
            child: Text(
              namaarb,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'noorehira',
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRight(audio, i) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 7,
      child: IconButton(
          icon: Icon(
            isplay[i] == true
                ? Icons.pause_circle_outline_rounded
                : Icons.play_circle_outline_rounded,
            color: isplay[i] == true ? Colors.green : Colors.black87,
          ),
          onPressed: () {
            playaudio(audio, i);
          }),
    );
  }
}
