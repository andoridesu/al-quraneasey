import 'package:easyalquran/config/constfunctionglobal.dart';
import 'package:easyalquran/config/loadingcomponent.dart';
import 'package:easyalquran/view/doa/liststringdoa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Kumpulandoa extends StatefulWidget {
  const Kumpulandoa({Key? key}) : super(key: key);

  @override
  _KumpulandoaState createState() => _KumpulandoaState();
}

class _KumpulandoaState extends State<Kumpulandoa> {
  bool isloading = true;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        isloading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kumpulan Doa "),
      ),
      body: isloading
          ? const Isloading()
          : ListView.separated(
              itemCount: localdata.length,
              itemBuilder: (context, int i) {
                return buildListdata(localdata[i], context);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                );
              },
            ),
    );
  }
}

Widget buildListdata(Map<String, Object> localdata, context) {
  return Container(
    padding: const EdgeInsets.all(15),
    child: InkWell(
      onTap: () {
        shoModal(context, localdata["title"], localdata["content"],
            localdata["arti"]);
      },
      child: Column(
        children: [
          Text(
            localdata["title"].toString(),
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          Text(
            localdata["content"].toString(),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
                fontSize: 28,
                fontFamily: 'noorehira',
                fontWeight: FontWeight.w500),
          ),
          Text(
            localdata["translate"].toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.green,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            child: Text(
              localdata["arti"].toString(),
            ),
          ),
        ],
      ),
    ),
  );
}
