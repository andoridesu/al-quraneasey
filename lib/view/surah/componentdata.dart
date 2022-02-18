import 'package:easyalquran/model/listmodel.dart';
import 'package:flutter/material.dart';

class Buildlistsurah extends StatelessWidget {
  final Modelsurah sur;
  final void play;
  const Buildlistsurah(this.sur, this.play, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPlay = false;
    var namaSurah = sur.namaLatin + '   ( ' + sur.arti + ' )';
    var jmlhayat = sur.tempatTurun.toUpperCase() +
        ' | ' +
        sur.jumlahAyat.toString() +
        ' Ayat';
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      leading: SizedBox(
        width: MediaQuery.of(context).size.width / 10,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: Image.asset(
                'assets/img/icnomor.png',
                width: 50,
              ),
            ),
            Center(
              child: Text(
                sur.nomor.toString(),
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.green),
              ),
            ),
          ],
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    namaSurah,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    jmlhayat,
                    style: const TextStyle(fontSize: 13, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Text(
              sur.nama,
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontSize: 25,
                  fontFamily: 'noorehira',
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      trailing: IconButton(
          icon: Icon(isPlay == true
              ? Icons.pause_circle_outline_rounded
              : Icons.play_circle_outline_rounded),
          onPressed: () {
            play;
          }),
      onTap: () {},
    );
  }
}
