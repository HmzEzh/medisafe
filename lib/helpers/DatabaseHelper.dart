import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:medisafe/models/Doze.dart';
import 'package:medisafe/models/Tracker.dart';
import 'package:medisafe/models/medicament.dart';
import 'package:medisafe/models/Users/user.dart';
import 'package:medisafe/models/medicamentDoze.dart';
import 'package:medisafe/utils/utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:medisafe/service/UserServices/UserService.dart';
import '../models/Mesure.dart';
import '../models/HistoriqueDoze.dart';
import '../models/RendezVous.dart';
import '../models/medcin.dart';
import 'package:path/path.dart';
import 'dart:io';

class DatabaseHelper {
  static UserService userService = UserService();
  static User utili = User.init(
      nom: "DOE",
      prenom: "Jhon",
      date_naissance: "1993-07-23",
      address: "3474 Tail Ends Road",
      age: 32,
      taille: 183,
      poids: 85,
      email: "jhondoe@gmail.com",
      password: "testjhon",
      tele: "+212 615-91203",
      blood: "A+");

  static const _databaseName = "medisafe";
  static const _databaseVersion = 1;
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
    final ByteData imageData =
        await rootBundle.load('assets/images/default.png');
    final Uint8List imageBytes = imageData.buffer.asUint8List();

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
            dateFin TEXT NOT NULL,
            forme TEXT NOT NULL
          );
          ''');
    await db.execute('''
          CREATE TABLE historiqueDoze (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            idDoze INTEGER NOT NULL,
            idMedicament INTEGER NOT NULL,
            valeur TEXT NOT NULL,
            remarque TEXT NOT NULL,
            datePrevu TEXT NOT NULL,
            FOREIGN KEY(idDoze) REFERENCES doze(id),
            FOREIGN KEY(idMedicament) REFERENCES medicament(id)
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
          CREATE TABLE tracker (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT NOT NULL,
            type TEXT NOT NULL,
            dateDebut TEXT NOT NULL,
            dateFin TEXT NOT NULL
          );
          ''');
    await db.execute('''
          CREATE TABLE mesure (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            idTracker INTEGER NOT NULL,
            value TEXT NOT NULL,
            date TEXT NOT NULL,
            heure TEXT NOT NULL,
            FOREIGN KEY(idTracker) REFERENCES tracker(id)
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
        blood TEXT NOT NULL,
        image BLOB      
      );
    ''');

    await db.execute('''
  INSERT INTO user (nom, prenom, date_naissance, address, age, taille, poids, email, password, tele, blood, image)
  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''', [
      utili.nom,
      utili.prenom,
      utili.date_naissance,
      utili.address,
      utili.age,
      utili.taille,
      utili.poids,
      utili.email,
      utili.password,
      utili.tele,
      utili.blood,
      imageBytes
    ]);

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

  /*Future<List<Map<String, dynamic>>> getUserById(int id) async {
    await init();
    return _db.query('user', orderBy: "id", where: 'id = ?', whereArgs: [
      id
    ], columns: [
      'id',
      'nom',
      'prenom',
      'image'
    ]); // Pass the columns you want to retrieve
  }*/

  Future<int> updateUserImage(int id, Uint8List imageBytes) async {
    final db = await instance.database;
    return await db.update(
      'user',
      {'image': imageBytes},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    await init();
    return _db.query('user', orderBy: "id");
  }

  Future<int> queryUsersCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM user');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // Rendez-Vous
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

  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM medcin');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> updateMedecin(Map<String, dynamic> row, int id) async {
    await init();
    return await _db.update(
      "medcin",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteMedecin(int id) async {
    await init();
    return await _db.delete(
      "medcin",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // historiqueDoze
  Future<int> insertHisto(Map<String, dynamic> row) async {
    await init();
    return await _db.insert("historiqueDoze", row);
  }

  Future<List<HistoriqueDoze>> historiqueDoze() async {
    await init();
    List<HistoriqueDoze> historique = [];
    for (Map<String, dynamic> item in await _db.query("historiqueDoze")) {
      historique.add(HistoriqueDoze.fromMap(item));
    }
    return historique;
  }

  Future<HistoriqueDoze?> findHistoBydozeAndDate(
      String date, int idDoze) async {
    await init();
    List<HistoriqueDoze> result = [];
    for (Map<String, dynamic> item in await _db.rawQuery(
        'SELECT * FROM historiqueDoze WHERE datePrevu LIKE "$date%" AND idDoze=$idDoze')) {
      HistoriqueDoze histo = HistoriqueDoze.fromMap(item);
      print(date);
      result.add(histo);
    }
    if (result.isEmpty) {
      return null;
    } else {
      return result[0];
    }
  }

  Future<int> updateHisto(Map<String, dynamic> row, int id) async {
    await init();
    return await _db.update(
      "historiqueDoze",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteHisto(int id) async {
    await init();
    return await _db.delete(
      "historiqueDoze",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // -- medicament
  Future<int> insertMedicament(String name, String type, String category,
      int nbrJour, String forme) async {
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
      'dateFin': dateFin,
      'forme': forme
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

  Future<List<MedicamentDoze>> getAllDozesByHeure(
      DateTime date, String heure) async {
    await init();
    List<MedicamentDoze> dozes = [];
    for (Map<String, dynamic> item
        in await _db.rawQuery('SELECT * FROM doze WHERE heure LIKE "$heure"')) {
      //dozes.add(Doze.fromMap(item));
      //TODO:

      if (await includeDoze(date, Doze.fromMap(item).idMedicament)) {
        dozes.add(await getMedicamentBydozeId(date, Doze.fromMap(item)));
      }
    }
    return dozes;
  }

  Future<bool> includeDoze(DateTime date, int dozeId) async {
    Medicament med = await getMedicamentBydoze(dozeId);
    List<String> list = med.dateFin.split('-');
    String day = list[0];
    String month = list[1];
    String year = list[2];
    if (day.length == 1) {
      day = "0$day";
    }
    if (month.length == 1) {
      month = "0$month";
    }
    DateTime dateFinal = DateTime.parse("$year-$month-$day");

    List<String> list2 = med.dateDebut.split('-');
    String day2 = list2[0];
    String month2 = list2[1];
    String year2 = list2[2];
    if (day2.length == 1) {
      day2 = "0$day2";
    }
    if (month2.length == 1) {
      month2 = "0$month2";
    }
    DateTime dateDebut = DateTime.parse("$year2-$month2-$day2");
    //print(list[2] + "-" + list[0] + "-" + list[1]);

    if (dateFinal.compareTo(date) >= 0 && dateDebut.compareTo(date) <= 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<Medicament> getMedicamentBydoze(int dozeId) async {
    await init();
    List<Medicament> result = [];
    for (Map<String, dynamic> item
        in await _db.rawQuery('SELECT * FROM medicament WHERE id="$dozeId"')) {
      Medicament medicament = Medicament.fromMap(item);
      result.add(medicament);
    }
    return result[0];
  }

  Future<MedicamentDoze> getMedicamentBydozeId(DateTime date, Doze doze) async {
    await init();
    List<MedicamentDoze> result = [];
    int? dozeId = doze.idMedicament;
    for (Map<String, dynamic> item
        in await _db.rawQuery('SELECT * FROM medicament WHERE id="$dozeId"')) {
      MedicamentDoze medicamentDoze = MedicamentDoze.fromMap(item);
      medicamentDoze.doze = doze;
      medicamentDoze.historique =
          await findHistoBydozeAndDate(Utils.formatDate(date), doze.id!);
      result.add(medicamentDoze);
    }

    return result[0];
  }

  Future<int> updateDoze(Map<String, dynamic> row, int id) async {
    await init();

    int a = await _db.update(
      "doze",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );

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

  // for Home page
  Future<Map<String, List<MedicamentDoze>>> calenderApi(DateTime date) async {
    Map<String, List<MedicamentDoze>> doseMap = {};
    List<Map<String, dynamic>> results =
        await db.query('doze', orderBy: 'heure');
    for (Map<String, dynamic> result in results) {
      Doze dose = Doze.fromMap(result);
      doseMap[dose.heure] = await getAllDozesByHeure(date, dose.heure);
    }
    doseMap.removeWhere((key, value) => value.isEmpty);
    return doseMap;
  }

  //Tracker

  Future<int> insertTracker(String name, String type, int nbrweeks) async {
    await init();
    DateTime now = DateTime.now();
    String dateDebut = "${now.day}-${now.month}-${now.year}";

    DateTime dateAfternWeeks = now.add(Duration(days: nbrweeks * 7));

    // Format the date as a string
    String dateFin =
        "${dateAfternWeeks.day}-${dateAfternWeeks.month}-${dateAfternWeeks.year}";

    final data = {
      'nom': name,
      'type': type,
      'dateDebut': dateDebut,
      'dateFin': dateFin,
    };
    int id = await _db.insert("tracker", data);

    return id;
  }

  Future<List<Tracker>> allTrackers() async {
    await init();
    List<Tracker> trackers = [];
    for (Map<String, dynamic> item in await _db.query("tracker")) {
      trackers.add(Tracker.fromMap(item));
    }

    return trackers;
  }

  Future<Tracker> getTrackerById(int id) async {
    await init();

    List<Tracker> trackers = [];
    for (Map<String, dynamic> item in await _db
        .query("tracker", orderBy: "id", where: 'id = ?', whereArgs: [id])) {
      trackers.add(Tracker.fromMap(item));
    }
    return trackers[0];
  }

  Future<List<Tracker>> getTrackersWithoutMesureToday() async {
    await init();

    DateTime now = DateTime.now();
    String today = "${now.day}-${now.month}-${now.year}";
    List<Tracker> trackers = [];

    for (Map<String, dynamic> item in await _db.rawQuery(
        "SELECT * FROM tracker WHERE id NOT IN (SELECT idTracker FROM mesure WHERE date = ?)",
        [today])) {
      trackers.add(Tracker.fromMap(item));
    }
    return trackers;
  }

  //mesures of Tracker

  Future<int> insertMesure(int idTracker, double value) async {
    await init();
    DateTime now = DateTime.now();
    String dateDebut = "${now.day}-${now.month}-${now.year}";

    int hour = now.hour;
    int minute = now.minute;
    int second = now.second;

    String time = "$hour:$minute:$second";

    final data = {
      'idTracker': idTracker,
      'value': value,
      'date': dateDebut,
      'heure': time,
    };
    int id = await _db.insert("mesure", data);

    return id;
  }

  Future<double> getHighest(int idTracker) async {
    try {
      final results = await _db.rawQuery(
          'SELECT MAX(value) AS max_value FROM mesure WHERE idTracker = ?',
          [idTracker]);
      final maxValue = results.isNotEmpty
          ? (double.parse(results.first['max_value'] as String))?.toDouble() ??
              0.0
          : 0.0;
      return maxValue;
    } on FormatException catch (e) {
      // Handle the type cast exception here
      print('Caught a FormatException: $e');
      return 0.0;
    } catch (e) {
      // Handle other exceptions here
      print('Caught an exception: $e');
      return 0.0;
    }
  }

  Future<double> getLowest(int idTracker) async {
    try {
      final results = await _db.rawQuery(
          'SELECT MIN(value) AS min_value FROM mesure WHERE idTracker = ?',
          [idTracker]);
      final maxValue = results.isNotEmpty
          ? (double.parse(results.first['min_value'] as String))?.toDouble() ??
              0.0
          : 0.0;
      return maxValue;
    } on FormatException catch (e) {
      // Handle the type cast exception here
      print('Caught a FormatException: $e');
      return 0.0;
    } catch (e) {
      // Handle other exceptions here
      print('Caught an exception: $e');
      return 0.0;
    }
  }

  Future<List<Mesure>> getMesuresByIdTracker(int id) async {
    await init();

    List<Mesure> mesures = [];
    for (Map<String, dynamic> item in await _db.query("mesure",
        orderBy: "id", where: 'idTracker = ?', whereArgs: [id])) {
      mesures.add(Mesure.fromMap(item));
    }
    return mesures;
  }
}
