import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

shareData(title, conten, arti) {
  var datashare = title + '\n' + conten + '\n' + arti;
  Share.share(datashare);
}

shoModal(context, title, conten, arti) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      context: context,
      builder: (context) {
        return Container(
          height: 100,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.share_outlined),
                title: const Text("Bagikan"),
                onTap: () {
                  Navigator.pop(context);
                  shareData(title, conten, arti);
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.bookmark_border_outlined),
              //   title: const Text('Bookmark'),
              //   onTap: () {},
              // ),
            ],
          ),
        );
      });
}

Future dialogdelBookmark(context, title, conten) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 16,
        title: Text(title),
        content: SizedBox(
          height: 100,
          child: Text(conten),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop('');
              },
              child: const Text('Batal')),
          TextButton(
              onPressed: () async {
                Navigator.of(context).pop('ok');
              },
              child: const Text('Ok Hapus')),
        ],
      );
    },
  );
}

Future dialogNtifikasi(context, isActive) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 16,
        title: Row(
          children: const [
            Icon(Icons.alarm_outlined),
            SizedBox(
              width: 10,
            ),
            Text('Atur Notifikasi'),
          ],
        ),
        content: SizedBox(
          height: 150,
          child: Column(
            children: [
              ListTile(
                leading:
                    Icon((isActive) ? Icons.brightness_3 : Icons.brightness_6),
                title: const Text(
                  "Notifikasi Default",
                ),
                trailing: Switch(
                    value: false,
                    activeColor: Colors.green,
                    onChanged: (bool value) {
                      isActive = !value;
                    }),
              ),
              ListTile(
                leading:
                    Icon((isActive) ? Icons.brightness_3 : Icons.brightness_6),
                title: const Text(
                  "Notifikasi Suara Adzan",
                ),
                trailing: Switch(
                    value: false,
                    activeColor: Colors.green,
                    onChanged: (bool value) {
                      isActive = !value;
                    }),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop('');
              },
              child: const Text('Batal')),
          TextButton(
              onPressed: () async {
                Navigator.of(context).pop('ok');
              },
              child: const Text('Ok Hapus')),
        ],
      );
    },
  );
}

snackBarscus(context, data) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(data)));
}
