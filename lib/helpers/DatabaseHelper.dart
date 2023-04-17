import 'package:medisafe/models/Doze.dart';
import 'package:medisafe/models/medicament.dart';
import 'package:medisafe/models/Users/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/RendezVous.dart';
import '../models/medcin.dart';

class DatabaseHelper {
  static const _databaseName = "medisafe";
  static const _databaseVersion = 2;
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
      onCreate: _onCreate, // Call the onUpgrade method
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

    await db.execute('''
          CREATE TABLE medicament (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT NOT NULL,
            type TEXT NOT NULL,
            category TEXT NOT NULL,
            dateDebut TEXT NOT NULL,
            dateFin TEXT NOT NULL
          );
          ''');
    await db.execute('''
          CREATE TABLE doze (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            idMedicament INTEGER NOT NULL,
            heure TEXT NOT NULL,
            suspend INTEGER NOT NULL,
            FOREIGN KEY(idMedicament) REFERENCES medicament(id)
          );
          ''');

    await db.execute('''
    CREATE TABLE user (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nom TEXT NOT NULL,
      prenom TEXT NOT NULL,
      date_naissance TEXT NOT NULL,
      address TEXT NOT NULL,
      age INTEGER NOT NULL,
      taille INTEGER NOT NULL,
      poids INTEGER NOT NULL,
      email TEXT NOT NULL,
      password TEXT NOT NULL,
      tele TEXT NOT NULL,
      blood TEXT NOT NULL      
    );
    ''');

    print("creating tables!!!!!!!!");
  }

  // user service !!

  Future<int> insertUser(Map<String, dynamic> row) async {
    await init();
    return await _db.insert("user", row);
  }

  Future<List<Map<String, dynamic>>> getUserById(int id) async {
    await init();
    return _db.query('user', orderBy: "id", where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    await init();
    return _db.query('user', orderBy: "id");
  }

  Future<int> queryUsersCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM user');
    return Sqflite.firstIntValue(results) ?? 0;
  }


  Future<List<RendezVous>> allRendezVous() async {
    await init();
    List<RendezVous> rendezVous = [];
    for (Map<String, dynamic> item in await _db.query("rendezVous")) {
      rendezVous.add(RendezVous.fromMap(item));
    }
    return rendezVous;
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

  // -- medicament
  Future<int> insertMedicament(
      String name, String type, String category, int nbrJour) async {
    await init();
    DateTime now = DateTime.now();
    String dateDebut = "${now.day}-${now.month}-${now.year}";

    DateTime dateAfternDays = now.add(Duration(days: nbrJour));

    // Format the date as a string
    String dateFin =
        "${dateAfternDays.day}-${dateAfternDays.month}-${dateAfternDays.year}";

    final data = {
      'nom': name,
      'type': type,
      'category': category,
      'dateDebut': dateDebut,
      'dateFin': dateFin
    };
    int id = await _db.insert("medicament", data);
    return id;
  }

  Future<List<Map<String, dynamic>>> getMedicaments() async {
    await init();
    return _db.query('medicament', orderBy: "id");
  }

  Future<List<Medicament>> getAllMedicaments() async {
    await init();
    List<Medicament> medicaments = [];
    for (Map<String, dynamic> item in await _db.query("medicament")) {
      medicaments.add(Medicament.fromMap(item));
    }
    return medicaments;
  }

  Future<List<Map<String, dynamic>>> getMedicamentById(int id) async {
    await init();
    return _db
        .query('medicament', orderBy: "id", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteMedicament(int id) async {
    await init();
    deleteDozes(id);
    return await _db.delete(
      "medicament",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateMedicament(Map<String, dynamic> row, int id) async {
    await init();
    return await _db.update(
      "medicament",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> countMedicaments() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM medicament');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> insertDoze(String heure, int id) async {
    await init();
    final data = {'idMedicament': id, 'heure': heure, 'suspend': 0};
    int id2 = await _db.insert("doze", data);
    return id2;
  }

  Future<List<Map<String, dynamic>>> getDozes() async {
    await init();
    return _db.query('doze', orderBy: "id");
  }

  Future<int> deleteDozes(int id) async {
    await init();
    return await _db.delete(
      "doze",
      where: 'idMedicament = ?',
      whereArgs: [id],
    );
  }

  Future<List<Doze>> getAllDozes() async {
    await init();
    List<Doze> dozes = [];
    for (Map<String, dynamic> item in await _db.query("doze")) {
      dozes.add(Doze.fromMap(item));
    }
    return dozes;
  }

  Future<int> updateDoze(Map<String, dynamic> row, int id) async {
    await init();
    print("hahoma ldakhel ${row} + id");
    int a = await _db.update(
      "doze",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
    print("dghdynj${a}");
    return a;
  }

  Future<int> deleteDoze(int id) async {
    await init();
    return await _db.delete(
      "doze",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Doze>> getDozesByIdMed(int id) async {
    await init();

    List<Doze> dozes = [];
    for (Map<String, dynamic> item in await _db.query("doze",
        orderBy: "id", where: 'idMedicament = ?', whereArgs: [id])) {
      dozes.add(Doze.fromMap(item));
    }
    return dozes;
  }

  Future<List<String>> getTableNames() async {
    final result =
        await _db.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
    final tableNames = result.map((row) => row['name'] as String).toList();
    return tableNames;
  }
}