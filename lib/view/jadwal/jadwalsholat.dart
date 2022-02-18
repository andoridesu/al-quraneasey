import 'package:easyalquran/config/loadingcomponent.dart';
import 'package:easyalquran/config/setlocalnotif.dart';
import 'package:easyalquran/config/shareprefenceseting.dart';
import 'package:easyalquran/service/jadwalservice.dart';
import 'package:easyalquran/service/lokasiservice.dart';
import 'package:easyalquran/view/home/componentwidget.dart';
import 'package:easyalquran/view/jadwal/calculatediferenttimes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Jadwalsholat extends StatefulWidget {
  const Jadwalsholat({Key? key}) : super(key: key);

  @override
  _JadwalsholatState createState() => _JadwalsholatState();
}

class _JadwalsholatState extends State<Jadwalsholat> {
  bool isloading = true;
  bool isSelected = false;
  String? lokasi = Sharepref.gets('curentlok') ?? '';
  String? kota = Sharepref.gets('kota') ?? '';
  String? hijri = Sharepref.gets('hijri') ?? '';
  String netTime = '';
  List jadwals = [];
  List<bool> isActive = [];
  String day = DateFormat('EEEE').format(DateTime.now());
  String time = DateFormat("HH:mm").format(DateTime.now());

  void getcurlok() {
    if (kota == '') {
      Lokasiservice.getposition().then((pos) {
        Lokasiservice.getAddressFromLatLong(pos).then((place) {
          var address =
              '${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.country}';
          setState(() {
            lokasi = address;
            kota = place.subAdministrativeArea.toString();
            Sharepref.sets('kota', kota!);
            Sharepref.sets('curentlok', address);
          });
          getjadwal(kota!);
        });
      });
    } else {
      getjadwal(kota!);
    }
  }

  void getjadwal(String kotas) {
    var date = DateFormat("yyyy/MM/dd").format(DateTime.now());
    if (kotas != '') {
      Jadwalervice.getidkota(kotas).then((id) {
        var enpoint = id + '/' + date;
        Jadwalervice.getjadwalnomodel(enpoint).then((value) {
          setState(() {
            jadwals.add(value);
            if (jadwals.isNotEmpty) {
              var arrytime = [
                jadwals[0]["imsak"],
                jadwals[0]["subuh"],
                jadwals[0]["terbit"],
                jadwals[0]["dzuhur"],
                jadwals[0]["ashar"],
                jadwals[0]["maghrib"],
                jadwals[0]["isya"],
              ];
              netTime = Claculatediferentime.calculates(time, arrytime);
            }
            isloading = false;
          });
        });
      });
    }
  }

  cekBoolpreference() {
    final keys = Claculatediferentime.namesholat;
    for (var i = 0; i < keys.length; i++) {
      var a = Sharepref.gets(keys[i].toLowerCase()) ?? '';
      if (a.isNotEmpty) {
        setOnofnotif(keys[i], true);
        setState(() => isActive.add(true));
      } else {
        setOnofnotif(keys[i], false);
        setState(() => isActive.add(false));
      }
    }
  }

  @override
  void initState() {
    cekBoolpreference();
    getcurlok();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter:
                  ColorFilter.mode(Colors.grey.shade800, BlendMode.darken),
              fit: BoxFit.cover,
              image: const AssetImage("assets/img/bgimages.jpg")),
        ),
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 3.7,
                width: MediaQuery.of(context).size.width,
                decoration: dekorbghead,
                child: Column(
                  children: [
                    AppBar(
                      elevation: 0,
                      centerTitle: true,
                      backgroundColor: Colors.transparent,
                      title: Text(
                        time,
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        IconButton(
                            tooltip: 'Refres Lokasi',
                            onPressed: () {
                              setState(() {
                                kota = '';
                                getcurlok();
                              });
                            },
                            icon: const Icon(Icons.refresh_rounded))
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(
                              width: 50,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.redAccent,
                              )),
                          Expanded(
                              child: Text(lokasi!,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white))),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          hijri!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          jadwals.isEmpty ? '' : jadwals[0]['tanggal'],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      netTime,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.yellowAccent),
                    ),
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: isloading
                    ? const Isloading()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        itemCount: Claculatediferentime.namesholat.length,
                        itemBuilder: (context, i) {
                          bool oNoF = isActive[i];
                          var name = Claculatediferentime.namesholat[i];
                          var key = name.toLowerCase();
                          return listJadwal(jadwals[0][key], name, oNoF, i);
                        },
                      )),
          ],
        ),
      ),
    );
  }

  Widget listJadwal(data, title, onof, i) {
    bool isTime = netTime.contains(title);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          SizedBox(
              width: 40,
              child: Image.asset(
                'assets/img/pray.png',
              )),
          Expanded(
              child: Text(title,
                  style: TextStyle(
                      color: isTime ? Colors.green : Colors.black,
                      fontWeight: FontWeight.w500))),
          SizedBox(
              width: 60,
              child: Text(data,
                  style: TextStyle(
                      color: isTime ? Colors.green : Colors.black,
                      fontWeight: FontWeight.w600))),
          SizedBox(
              width: 50,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      isActive[i] = !onof;
                      setOnofnotif(title, isActive[i]);
                      if (onof == false) {
                        Setlocalnotif.setSchedule(data, i, title);
                      } else {
                        Setlocalnotif.deleteNotificationChannel(i.toString());
                      }
                    });
                  },
                  icon: Icon(
                    onof == true
                        ? Icons.notifications_active
                        : Icons.notifications,
                    color: onof == true ? Colors.green : Colors.black54,
                  ))),
        ],
      ),
    );
  }

  void setOnofnotif(String key, bool bool) {
    var val = bool == true ? key : '';
    Sharepref.sets(key.toLowerCase(), val);
  }
}
