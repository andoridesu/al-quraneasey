import 'package:easyalquran/config/constfunctionglobal.dart';
import 'package:easyalquran/config/dbhelper.dart';
import 'package:easyalquran/config/loadingcomponent.dart';
import 'package:easyalquran/view/details/detailsurah.dart';
import 'package:flutter/material.dart';

class Historibaca extends StatefulWidget {
  const Historibaca({Key? key}) : super(key: key);

  @override
  _HistoribacaState createState() => _HistoribacaState();
}

class _HistoribacaState extends State<Historibaca> {
  bool isloading = true;
  List historilist = [];

  Future<void> gethistori() async {
    var res = await Dbhistori.getHistori();
    setState(() {
      isloading = false;
      if (res != null) {
        historilist = res;
      }
    });
  }

  delhistori(id, i) async {
    var res = await Dbhistori.delHistori(id);
    setState(() {
      if (res == 1) {
        gethistori();
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(const SnackBar(content: Text('Berhasil di hapus')));
      }
    });
  }

  void _delet(id, i) {
    var title = 'Hapus Bookmark';
    var cntn =
        'Anda yakin ingin menghapus data ini?\nData yang di hapus tidak bisa di pulihkan kembali!';
    dialogdelBookmark(context, title, cntn).then((value) {
      if (value == 'ok') {
        delhistori(id, i);
      }
    });
  }

  @override
  void initState() {
    gethistori();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
      ),
      body: isloading
          ? const Isloading()
          : historilist.isEmpty
              ? const Center(
                  child: Text('Belum Ada Bookmark!'),
                )
              : ListView.separated(
                  itemCount: historilist.isEmpty ? 0 : historilist.length,
                  itemBuilder: (context, i) {
                    var data = historilist[i];
                    return ListTile(
                      leading: const Icon(Icons.bookmark_added),
                      title: Text(data['name'] + ' (' + data['arti'] + ')'),
                      onLongPress: () {
                        _delet(data['numid'], i);
                      },
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Detailsurah(data['numid'])));
                      },
                    );
                  },
                  separatorBuilder: (context, i) {
                    return const Divider(
                      indent: 60,
                      height: 1,
                    );
                  },
                ),
    );
  }
}
