import 'package:intl/intl.dart';

class Claculatediferentime {
  static List<String> namesholat = [
    "Imsak",
    "Subuh",
    "Terbit",
    "Dzuhur",
    "Ashar",
    "Maghrib",
    "Isya",
  ];

  static String calculates(time, arrytime) {
    var ts = Claculatediferentime.cekTimesholat(time, arrytime);
    var tend = ts.split(' ');
    var dateFormat = DateFormat('HH:mm');
    DateTime durationStart = dateFormat.parse(time);
    DateTime durationEnd = dateFormat.parse(tend[0]);
    var mnt = durationEnd.difference(durationStart).inMinutes;
    var okedata =
        mnt > 0 ? durationToString(mnt) + ' Menuju Waktu ' + tend[1] : '';
    return okedata;
  }

  static cekTimesholat(times, tShalat) {
    var time = timeToInt(times);

    if (time >= timeToInt(tShalat[0]) && time < timeToInt(tShalat[1])) {
      return tShalat[1] + ' ' + namesholat[1];
    } else if (time >= timeToInt(tShalat[1]) && time < timeToInt(tShalat[2])) {
      return tShalat[2] + ' ' + namesholat[2];
    } else if (time >= timeToInt(tShalat[2]) && time < timeToInt(tShalat[3])) {
      return tShalat[3] + ' ' + namesholat[3];
    } else if (time >= timeToInt(tShalat[3]) && time < timeToInt(tShalat[4])) {
      return tShalat[4] + ' ' + namesholat[4];
    } else if (time >= timeToInt(tShalat[4]) && time < timeToInt(tShalat[5])) {
      return tShalat[5] + ' ' + namesholat[5];
    } else if (time >= timeToInt(tShalat[5]) && time < timeToInt(tShalat[6])) {
      return tShalat[6] + ' ' + namesholat[6];
    } else if (time >= timeToInt(tShalat[6]) || time < timeToInt(tShalat[0])) {
      return tShalat[0] + ' ' + namesholat[0];
    } else {
      return "";
    }
  }

  static cekCurentholat(times, tShalat) {
    var time = timeToInt(times);

    if (time >= timeToInt(tShalat[0]) && time < timeToInt(tShalat[1])) {
      return namesholat[0];
    } else if (time >= timeToInt(tShalat[1]) && time < timeToInt(tShalat[2])) {
      return namesholat[1];
    } else if (time >= timeToInt(tShalat[2]) && time < timeToInt(tShalat[3])) {
      return namesholat[2];
    } else if (time >= timeToInt(tShalat[3]) && time < timeToInt(tShalat[4])) {
      return namesholat[3];
    } else if (time >= timeToInt(tShalat[4]) && time < timeToInt(tShalat[5])) {
      return namesholat[4];
    } else if (time >= timeToInt(tShalat[5]) && time < timeToInt(tShalat[6])) {
      return namesholat[5];
    } else if (time >= timeToInt(tShalat[6]) || time < timeToInt(tShalat[0])) {
      return namesholat[6];
    } else {
      return "";
    }
  }

  static int timeToInt(time) {
    var data = time.split(":");
    if (data.length > 2 && data.length <= 3) {
      return (int.parse(data[0]) * 3600) +
          (int.parse(data[1]) * 60) +
          int.parse(data[2]);
    } else if (data.length > 1 && data.length <= 2) {
      return (int.parse(data[0]) * 3600) + (int.parse(data[1]) * 60);
    } else {
      return int.parse(data[0]);
    }
  }

  static String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    if (minutes > 60) {
      return '${parts[0].padLeft(2, '0')} Jam ${parts[1].padLeft(2, '0')} Menit';
    } else {
      return ' ${parts[1].padLeft(2, '0')} Menit';
    }
  }
}
