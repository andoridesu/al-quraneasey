import 'package:audioplayers/audioplayers.dart';
import 'package:easyalquran/config/dbhelper.dart';
import 'package:easyalquran/config/loadingcomponent.dart';
import 'package:easyalquran/service/detailservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'componenlist.dart';

class Detailsurah extends StatefulWidget {
  final String id;
  const Detailsurah(this.id, {Key? key}) : super(key: key);

  @override
  _DetailsurahState createState() => _DetailsurahState();
}

class _DetailsurahState extends State<Detailsurah> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isloading = true;
  bool isPlay = false;
  bool isbokmark = false;
  List _listayat = [];
  String judul = '';
  String jayat = '';
  String artisur = '';
  String audio = '';

  void getdata() {
    Apidetailsurah.details(widget.id).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          judul = value['nama_latin'];
          jayat = value['tempat_turun'] + ' ' + value['jumlah_ayat'].toString();
          audio = value['audio'];
          artisur = value['arti'];
          _listayat = value['ayat'];
          isloading = false;
        });
      }
    });
  }

  void playaudio(url) async {
    setState(() {
      isPlay = !isPlay;
    });
    if (!isPlay) {
      await audioPlayer.stop();
    } else {
      await audioPlayer.play(url);
      audioPlayer.onPlayerCompletion.listen((event) {
        setState(() {
          isPlay = !isPlay;
        });
      });
    }
  }

  void setbookmark(name, numid, arti) async {
    if (isbokmark == true) {
      await Dbhistori.delHistori(numid);
    } else {
      await Dbhistori.createHs(name, numid, arti);
    }
    setState(() {
      isbokmark = !isbokmark;
    });
  }

  @override
  void initState() {
    getdata();
    Dbhistori.checkHistory(widget.id).then((value) => isbokmark = value);
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isloading
            ? const Isloading()
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    elevation: 0,
                    centerTitle: true,
                    pinned: true,
                    actions: [
                      IconButton(
                          tooltip: 'Tambah Bookmark',
                          onPressed: () {
                            setbookmark(judul, widget.id, artisur);
                          },
                          icon: Icon(Icons.bookmark_add_outlined,
                              color: isbokmark ? Colors.yellow : Colors.white)),
                      IconButton(
                          tooltip: 'Play audio',
                          onPressed: () {
                            playaudio(audio);
                          },
                          icon: Icon(isPlay == true
                              ? Icons.pause_circle_outline_rounded
                              : Icons.play_circle_outline_rounded))
                    ],
                    title: Text(
                      judul,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50)),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/img/headersur.jpg")),
                      ),
                      child: Componenheadertitle(artisur, jayat),
                    ),
                  ),
                  SliverAnimatedList(
                    initialItemCount: _listayat.length,
                    itemBuilder: (context, int i, animation) {
                      var dataayat = Map.from(_listayat[i]);
                      return Componenlistsurah(dataayat, judul);
                    },
                  ),
                ],
              ));
  }
}
