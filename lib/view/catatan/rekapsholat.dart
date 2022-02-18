import 'package:easyalquran/config/constfunctionglobal.dart';
import 'package:easyalquran/config/dbhelper.dart';
import 'package:easyalquran/view/catatan/list_rekap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'component_header.dart';

class Rekapsholat extends StatefulWidget {
  const Rekapsholat({Key? key}) : super(key: key);

  @override
  _RekapsholatState createState() => _RekapsholatState();
}

class _RekapsholatState extends State<Rekapsholat> {
  bool isloading = false;
  final _ctrcatat = TextEditingController();
  String selected = '';
  List _rekap = [];
  List drpDown = [
    "Subuh",
    "Dzuhur",
    "Ashar",
    "Maghrib",
    "Isya",
  ];

  Future<void> getrekap() async {
    var dt = DateFormat("dd-MM-yyyy").format(DateTime.now());
    var res = await Dbhistori.getRecap(dt);
    setState(() {
      isloading = false;
      if (res != null) {
        _rekap = res;
      }
    });
  }

  Future<void> simpanNote() async {
    var dt = DateFormat("dd-MM-yyyy").format(DateTime.now());
    if (selected != '') {
      Dbhistori.checRecap(selected, dt).then((res) async {
        if (res == false) {
          await Dbhistori.createRecap(selected, dt, _ctrcatat.text);
          setState(() {
            selected = '';
            _ctrcatat.clear();
          });
          getrekap();
        } else {
          snackBarscus(context, 'Data $selected sudah ada');
          setState(() {
            selected = '';
            _ctrcatat.clear();
          });
        }
      });
    } else {
      snackBarscus(context, 'Data tidak boleh kosong!');
      _ctrcatat.clear();
    }
  }

  dialogInputRekap(context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 16,
          title: const Text('Tambah Catatan'),
          content: Container(
            constraints: const BoxConstraints(
                minHeight: 130, maxHeight: 150, maxWidth: 300),
            child: Column(
              children: [
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    iconSize: 30,
                    hint: const Text("Pilih Sholat"),
                    items: drpDown
                        .map((label) => DropdownMenuItem<String>(
                              child: Text(label),
                              value: label,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => selected = value.toString());
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _ctrcatat,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  minLines: 1,
                  decoration: const InputDecoration(
                      hintText: 'Catatan ', labelText: "Catatan"),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    selected = '';
                    _ctrcatat.clear();
                  });
                },
                child: const Text(
                  'Batal',
                  style: TextStyle(color: Colors.grey),
                )),
            TextButton(
                onPressed: () async {
                  simpanNote();
                  Navigator.of(context).pop();
                },
                child: const Text('Simpan')),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    getrekap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rekap Sholat'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            dialogInputRekap(context);
          },
          child: const Icon(
            Icons.add_circle_outline_rounded,
            size: 30,
          ),
        ),
        body: _rekap.isEmpty
            ? const Center(
                child: Text('Belum ada note!'),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Headerrekap(),
                          SizedBox(
                            height: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                itemCount: _rekap.length,
                                itemBuilder: (context, i) {
                                  var data = _rekap[i];
                                  return Listrekap(
                                    data['name'],
                                    data['date'],
                                    data['note'],
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
