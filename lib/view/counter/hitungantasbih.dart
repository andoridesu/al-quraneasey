import 'package:easyalquran/view/counter/counter.dart';
import 'package:flutter/material.dart';

import 'consttasbih.dart';

class Hitungantasbih extends StatefulWidget {
  const Hitungantasbih({Key? key}) : super(key: key);

  @override
  _HitungantasbihState createState() => _HitungantasbihState();
}

class _HitungantasbihState extends State<Hitungantasbih> {
  void movePages(name, art) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Countertasbih(name, art)),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hitung Tasbih'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          movePages('', '');
        },
        child: const Icon(Icons.add_task),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 5),
        itemCount: Listtasbih.tasbih.length,
        itemBuilder: (context, int i) {
          var ts = Listtasbih.tasbih[i];
          return buildListdata(ts);
        },
        separatorBuilder: (context, i) {
          return const Divider(
            height: 1,
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 50,
      ),
    );
  }

  Widget buildListdata(ts) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      leading: const Icon(
        Icons.timer,
        size: 30,
      ),
      title: Text(
        ts['name'],
      ),
      onTap: () {
        movePages(ts['name'], ts['ar']);
      },
    );
  }
}
