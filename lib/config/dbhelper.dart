import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbhistori {
  static final instance = Dbhistori._init();
  static Database? _db;
  static String nameTable = 'historibaca';

  Dbhistori._init();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDB('histori.db');
    return _db!;
  }

  static Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  static FutureOr<void> _createDb(Database db, int version) {
    db.execute(
        'CREATE TABLE IF NOT EXISTS $nameTable (id INTEGER PRIMARY KEY, name TEXT, numid TEXT, arti TEXT)');
    db.execute(
        'CREATE TABLE IF NOT EXISTS rekapsholat (id INTEGER PRIMARY KEY, name TEXT, date TEXT, note TEXT)');
  }

  // bookmarks

  static Future createHs(String name, String numid, String arti) async {
    final dbs = await instance.db;
    var tb = 'name, numid, arti';
    var val = '"$name", "$numid", "$arti"';
    final id = dbs.rawInsert('INSERT INTO $nameTable($tb) VALUES($val)');

    debugPrint('inserted1: $id');
  }

  static Future getHistori() async {
    final dbs = await instance.db;
    var data = await dbs.rawQuery('SELECT * FROM $nameTable ORDER BY id DESC');
    return data;
  }

  static Future<bool> checkHistory(String id) async {
    final dbs = await instance.db;
    String select = "SELECT * FROM $nameTable  WHERE numid = ? ";
    var res = await dbs.rawQuery(select, [id]);
    return res.isEmpty ? false : true;
  }

  static Future delHistori(nid) async {
    final dbs = await instance.db;
    var data =
        await dbs.rawDelete('DELETE FROM $nameTable WHERE numid = ?', [nid]);
    return data;
  }

  static Future delallHistori() async {
    final dbs = await instance.db;
    var data = await dbs.rawDelete('DELETE FROM $nameTable');
    return data;
  }

  // Rekap sholat >>

  static Future createRecap(String name, String date, String note) async {
    final dbs = await instance.db;
    var tb = 'rekapsholat';
    var field = 'name, date, note';
    var val = '"$name", "$date", "$note"';
    final id = dbs.rawInsert('INSERT INTO $tb($field) VALUES($val)');

    debugPrint('inserted1: $id');
  }

  static Future getRecap(date) async {
    final dbs = await instance.db;
    var tb = 'rekapsholat';
    String select = "SELECT * FROM $tb  WHERE date = ?  ORDER BY id DESC";
    var res = await dbs.rawQuery(select, [date]);
    // var res = await dbs.rawQuery('SELECT * FROM $tb  WHERE numid = ?  ORDER BY id DESC');
    return res;
  }

  static Future<bool> checRecap(String name, String date) async {
    final dbs = await instance.db;
    var tb = 'rekapsholat';
    String select = "SELECT * FROM $tb  WHERE name = ? AND date = ?";
    var res = await dbs.rawQuery(select, [name, date]);
    return res.isEmpty ? false : true;
  }

  static Future delallrecap() async {
    final dbs = await instance.db;
    var tb = 'rekapsholat';
    var data = await dbs.rawDelete('DELETE FROM $tb');
    return data;
  }

  // Rekap sholat //

  static Future close() async {
    final dbs = await instance.db;
    dbs.close();
  }
}
