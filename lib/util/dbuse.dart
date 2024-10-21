import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/scol_list.dart';

class dbuse {
  final int version = 1;
  Database? db;
  static final dbuse _dbHelper = dbuse._internal();
  dbuse._internal();
  factory dbuse() {
    return _dbHelper;
  }
  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'scol2.db'),
          onCreate: (database, version) {
        database.execute(
            'CREATE TABLE classes(codClass INTEGER PRIMARY KEY, nomClass TEXT, nbreEtud INTEGER)');
        database.execute(
            'CREATE TABLE etudiants(id INTEGER PRIMARY KEY, codClass INTEGER,nom TEXT, prenom TEXT, datNais TEXT, ' +
                'FOREIGN KEY(codClass) REFERENCES classes(codClass))');
      }, version: version);
    }
    return db!;
  }

  Future testDb() async {
    db = await openDb();
    await db?.execute('INSERT INTO classes VALUES (101, "DSI31", 28)');
    await db?.execute(
        'INSERT INTO etudiants VALUES (10, 101, "Ben Foulen", "Foulen", "05/10/2023")');
    List lists = await db!.rawQuery('select * from classes');
    List items = await db!.rawQuery('select * from etudiants');
    print(lists[0].toString());
    print(items[0].toString());
  }

  Future<List<ScolList>> getClasses() async {
    final List<Map<String, dynamic>> maps = await db!.query('classes');
    return List.generate(maps.length, (i) {
      return ScolList(
        maps[i]['codClass'],
        maps[i]['nomClass'],
        maps[i]['nbreEtud'],
      );
    });
  }
}
