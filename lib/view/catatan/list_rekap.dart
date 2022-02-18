import 'package:flutter/material.dart';

class Listrekap extends StatelessWidget {
  final String sholat;
  final String tgl;
  final String note;
  const Listrekap(this.sholat, this.tgl, this.note, {Key? key})
      : super(key: key);

  final styles = const TextStyle(
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width / 3.2;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: wid, child: Text(sholat, style: styles)),
          SizedBox(width: wid, child: Text(tgl, style: styles)),
          Expanded(child: Text(note, style: styles)),
        ],
      ),
    );
  }
}
