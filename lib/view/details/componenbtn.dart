import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

class Componenbtn extends StatelessWidget {
  final String arab;
  final String tr;
  const Componenbtn(this.arab, this.tr, {Key? key}) : super(key: key);

  void copytext(data) {}

  void terjemhan(data, context) {
    showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Html(
                  data: data,
                  style: {
                    "body": Style(
                        fontSize: const FontSize(16.0),
                        fontWeight: FontWeight.w400,
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(0),
                        color: Colors.grey[700],
                        fontFamily: GoogleFonts.lato().fontFamily,
                        fontStyle: GoogleFonts.lato().fontStyle,
                        textAlign: TextAlign.justify),
                    "p": Style(
                      fontSize: const FontSize(16.0),
                      fontWeight: FontWeight.w400,
                      margin: const EdgeInsets.all(0),
                    )
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(onTap: () {}, child: const Icon(Icons.copy)),
          const SizedBox(
            height: 7,
          ),
          GestureDetector(
              onTap: () {
                terjemhan(tr, context);
              },
              child: const Icon(Icons.info_outline))
        ],
      ),
    );
  }
}
