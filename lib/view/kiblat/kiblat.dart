import 'dart:async';
import 'dart:math';

import 'package:easyalquran/config/loadingcomponent.dart';
import 'package:easyalquran/service/lokasiservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';

import 'errolokasicompas.dart';

class Kiblatviewcompas extends StatefulWidget {
  const Kiblatviewcompas({Key? key}) : super(key: key);

  @override
  _KiblatviewcompasState createState() => _KiblatviewcompasState();
}

class _KiblatviewcompasState extends State<Kiblatviewcompas> {
  final deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  cekstatusview(snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Isloading();
    } else if (snapshot.hasError) {
      return Center(
        child: Text("Error: ${snapshot.error.toString()}"),
      );
    } else if (snapshot.data!) {
      return const Qiblahcompass();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arah Qiblat'),
      ),
      body: FutureBuilder(
        future: deviceSupport,
        builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
          return cekstatusview(snapshot);
        },
      ),
    );
  }
}

// view

class Qiblahcompass extends StatefulWidget {
  const Qiblahcompass({Key? key}) : super(key: key);

  @override
  _QiblahcompassState createState() => _QiblahcompassState();
}

class _QiblahcompassState extends State<Qiblahcompass> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  get stream => _locationStreamController.stream;

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Isloading();
          }
          if (snapshot.data!.enabled == true) {
            switch (snapshot.data!.status) {
              case LocationPermission.always:
              case LocationPermission.whileInUse:
                return const QiblahcompassWidget();
              case LocationPermission.denied:
                return LocationErrorWidget(
                  error: "Location service permission denied",
                  callback: _checkLocationStatus,
                );
              case LocationPermission.deniedForever:
                return LocationErrorWidget(
                  error: "Location service Denied Forever !",
                  callback: _checkLocationStatus,
                );
              default:
                return Container();
            }
          } else {
            return LocationErrorWidget(
              error: "Please enable Location service",
              callback: _checkLocationStatus,
            );
          }
        },
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    Lokasiservice.getposition();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else {
      _locationStreamController.sink.add(locationStatus);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }
}

class QiblahcompassWidget extends StatelessWidget {
  const QiblahcompassWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _compassSvg = Image.asset('assets/img/compass.png');
    final _needleSvg = Image.asset(
      'assets/img/needle.png',
      fit: BoxFit.contain,
      height: 300,
      alignment: Alignment.center,
    );

    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Isloading();
        }
        final qiblahDirection = snapshot.data!;
        return Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: <Widget>[
            Transform.rotate(
              angle: (qiblahDirection.direction * (pi / 180) * -1),
              child: _compassSvg,
            ),
            Transform.rotate(
              angle: (qiblahDirection.qiblah * (pi / 180) * -1),
              alignment: Alignment.center,
              child: _needleSvg,
            ),
            Positioned(
              bottom: 0,
              child: Text(
                "${qiblahDirection.offset.toStringAsFixed(3)}°",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          ],
        );
      },
    );
  }
}
