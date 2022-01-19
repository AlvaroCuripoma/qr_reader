import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static late Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> database() async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(''' 
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          Valor TEXT
        )
       ''');
      },
    );
  }

  nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    final db = await _database;
    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
      VALUES($id, '$tipo','$valor')
    ''');
    return res;
  }

  nuevoScan(ScanModel nuevoScan) async {
    final db = await _database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    return res;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await _database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }
}
