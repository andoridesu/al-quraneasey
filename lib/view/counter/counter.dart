import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Countertasbih extends StatefulWidget {
  final String title;
  final String ar;
  const Countertasbih(this.title, this.ar, {Key? key}) : super(key: key);

  @override
  _CountertasbihState createState() => _CountertasbihState();
}

class _CountertasbihState extends State<Countertasbih> {
  int _count = 0;

  void counnumber() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title == '' ? 'Hitung' : widget.title),
        ),
        body: Column(
          children: [
            widget.title == ''
                ? Container(
                    height: 50,
                  )
                : Container(
                    height: widget.title == 'Tahlil' ? 160 : 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/img/headersur.jpg")),
                    ),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 120,
                        padding: EdgeInsets.only(
                            right: widget.title == 'Tahlil' ? 12 : 0),
                        child: Center(
                          child: Text(widget.ar,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: widget.title == 'Tahlil' ? 20 : 25,
                                  fontFamily: 'noorehira',
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width / 1.8,
                    margin: const EdgeInsets.all(50.0),
                    decoration: const BoxDecoration(
                        color: Colors.orange, shape: BoxShape.circle),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width / 2,
                    margin: const EdgeInsets.all(50.0),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        _count.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _count = 0;
                });
              },
              child: Container(
                  width: 100,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Text(
                      'Reset Ulang',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
            MaterialButton(
              onPressed: () {
                counnumber();
              },
              child: Container(
                  height: 100,
                  width: 150,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(40)),
                  child: const Center(
                    child: Text(
                      'Tambah',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            )
          ],
        ));
  }
}
