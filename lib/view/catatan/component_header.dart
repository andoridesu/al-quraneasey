import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Headerrekap extends StatelessWidget {
  const Headerrekap({Key? key}) : super(key: key);
  final styles =
      const TextStyle(fontWeight: FontWeight.bold, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width / 3.2;

    return Container(
      color: Colors.green,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: wid, child: Text('Sholat', style: styles)),
          SizedBox(width: wid, child: Text('Tanggal', style: styles)),
          Expanded(child: Text('Catatan', style: styles)),
        ],
      ),
    );
  }
}
