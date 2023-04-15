import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/medcin.dart';

class DatabaseHelper {
  static const _databaseName = "pfa.db";
  static const _databaseVersion = 3;
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  late Database _db;
  Future<Database> get database async {
    if (_db != null) return _db;
    // lazily instantiate the db the first time it is accessed
    _db = await init();
    return _db;
  }
  Database get db => _db;
  // this opens the database (and creates it if it doesn't exist)
  Future<Database> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
    return _db;
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE medcin (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT NOT NULL,
            specialite TEXT NOT NULL,
            email TEXT NOT NULL,
            adress TEXT NOT NULL,
            tele TEXT NOT NULL,
            bureau TEXT NOT NULL
          );
          ''');
    await db.execute('''
          CREATE TABLE rendezVous (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            medecinId INTEGER,
            nom TEXT NOT NULL,
            lieu TEXT NOT NULL,
            remarque TEXT NOT NULL,
            heure TEXT NOT NULL,
            FOREIGN KEY (medecinId) REFERENCES medcin (id)                  
               ON DELETE NO ACTION ON UPDATE NO ACTION
           
          );
          ''');
  }
  // medecin service !!

  Future<int> insertMedecin(Map<String, dynamic> row) async {
    await init();
    return await _db.insert("medcin", row);
  }

  Future<List<Medcin>> queryAllRowsMedecin() async {
    await init();
    List<Medcin> medcins = [];
    for (Map<String, dynamic> item in await _db.query("medcin")) {
      medcins.add(Medcin.fromMap(item));
    }

    return medcins;
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM medcin');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> updateMedecin(Map<String, dynamic> row, int id) async {
    await init();
    return await _db.update(
      "medcin",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> deleteMedecin(int id) async {
    await init();
    return await _db.delete(
      "medcin",
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
