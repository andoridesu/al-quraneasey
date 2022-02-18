import 'package:easyalquran/config/constfunctionglobal.dart';
import 'package:easyalquran/config/htmltextview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Componenlistsurah extends StatelessWidget {
  final String title;
  final Map dataayat;
  const Componenlistsurah(this.dataayat, this.title, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widrigt = MediaQuery.of(context).size.width / 10;
    return InkWell(
      onTap: () {
        shoModal(
          context,
          title,
          dataayat['ar'],
          dataayat['idn'],
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: widrigt,
                child: Contennomor(dataayat['nomor'].toString())),
            Expanded(
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Contentext(dataayat)),
            ),
          ],
        ),
      ),
    );
  }
}

class Contentext extends StatelessWidget {
  final Map data;
  const Contentext(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          data['ar'],
          softWrap: true,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: const TextStyle(
              fontSize: 25,
              fontFamily: 'noorehira',
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 7,
        ),
        Htmltext(
            data['tr'] +
                ' <strong> ( ' +
                data['nomor'].toString() +
                ' )</strong>',
            false),
        const SizedBox(
          height: 7,
        ),
        Htmltext(data['idn'], true),
      ],
    );
  }
}

class Contennomor extends StatelessWidget {
  final String no;
  const Contennomor(this.no, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
            child: Image.asset(
              'assets/img/icnomor.png',
              width: 50,
              color: Colors.white24,
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Positioned(
            top: 8,
            left: 17,
            child: Center(
              child: Text(
                no,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'noorehira',
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Componenheadertitle extends StatelessWidget {
  final String arti;
  final String jayat;
  const Componenheadertitle(this.arti, this.jayat, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widt = MediaQuery.of(context).size.width / 3.8;
    var ayat = jayat.split(' ');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: widt,
          child: Text(
            ayat[0],
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 16, color: Colors.brown),
          ),
        ),
        Expanded(
          child: Text(
            arti,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20, color: Colors.brown, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          width: widt,
          child: Text(
            ayat[1] + ' Ayat',
            style: const TextStyle(fontSize: 16, color: Colors.brown),
          ),
        ),
      ],
    );
  }
}
