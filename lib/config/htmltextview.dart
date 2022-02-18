import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

class Htmltext extends StatelessWidget {
  final String data;
  final bool tx;
  const Htmltext(this.data, this.tx, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      style: {
        "body": Style(
            fontSize: const FontSize(17.0),
            fontWeight: FontWeight.w400,
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            color: tx ? Colors.grey[700] : Colors.green[800],
            fontFamily: GoogleFonts.lato().fontFamily,
            fontStyle: GoogleFonts.lato().fontStyle,
            textAlign: TextAlign.justify),
        "p": Style(
          fontSize: const FontSize(16.0),
          fontWeight: FontWeight.w400,
          margin: const EdgeInsets.all(0),
        )
      },
    );
  }
}
