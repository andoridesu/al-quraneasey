import 'package:easyalquran/config/shareprefenceseting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration dekorbg = const BoxDecoration(
  image: DecorationImage(
      colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
      fit: BoxFit.cover,
      image: AssetImage("assets/img/bgimages.jpg")),
);

BoxDecoration dekorbghead = const BoxDecoration(
  borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(160), bottomRight: Radius.circular(160)),
  image: DecorationImage(
      colorFilter: ColorFilter.mode(Colors.green, BlendMode.darken),
      fit: BoxFit.cover,
      image: AssetImage("assets/img/bgimages.jpg")),
);

// Widget header

class Headercomponent extends StatelessWidget {
  final String date;
  final String day;
  final String time;
  final String great;

  const Headercomponent(this.date, this.day, this.time, this.great, {Key? key})
      : super(key: key);

  getbg(prop) {
    if (prop == 'Pagi') {
      return Image.asset('assets/img/morning.png');
    } else if (prop == 'Siang') {
      return Image.asset('assets/img/afternoon.png');
    } else if (prop == 'Sore') {
      return Image.asset('assets/img/sunsets.png');
    } else {
      return Image.asset('assets/img/malam.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    var hj = Sharepref.gets('hijri') ?? '';
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width,
          decoration: dekorbghead,
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        SizedBox(child: Builder(builder: (context) {
                          return Text(
                            time,
                            style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        })),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              day + ' - ' + date,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            )),
                        SizedBox(
                            child: Text(
                          hj,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        )),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 5, top: 0),
                          width: 80,
                          child: getbg(great),
                        ),
                        Text(
                          great,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
